import 'dart:async';

import 'package:edifika_mobile/core/network/api_exception.dart';
import 'package:edifika_mobile/core/utils/load_status.dart';
import 'package:edifika_mobile/features/iot/domain/iot_models.dart';
import 'package:edifika_mobile/features/iot/presentation/iot_management_cubit.dart';
import 'package:edifika_mobile/features/residential/domain/residential_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fakes.dart';

void main() {
  late MockIotRepository iot;
  late MockResidentialRepository residential;

  const torre = Building(id: 12, name: 'Torre Mirador');
  const olivos = Building(id: 1, name: 'Edificio Los Olivos');

  IotManagementCubit build() => IotManagementCubit(iot: iot, residential: residential);

  setUp(() {
    iot = MockIotRepository();
    residential = MockResidentialRepository();
    when(() => residential.getBuildings()).thenAnswer((_) async => [torre, olivos]);
    when(() => iot.getGateways(any())).thenAnswer((_) async => []);
    when(() => iot.getDevices(any())).thenAnswer((_) async => []);
    when(() => iot.getTelemetry(any())).thenAnswer((_) async => []);
  });

  test('elige el primer edificio por nombre y carga sus gateways, dispositivos y telemetría', () async {
    when(() => iot.getGateways(1)).thenAnswer((_) async => [iotGateway]);
    when(() => iot.getDevices(1)).thenAnswer((_) async => [
          iotDevice,
          iotDevice.copyWith(id: 4, deviceCode: 'esp32-acc-02', name: 'Puerta gimnasio', status: 'OFFLINE'),
          iotDevice.copyWith(id: 5, deviceCode: 'esp32-acc-03', name: 'Puerta azotea', status: 'MAINTENANCE'),
          iotDevice.copyWith(id: 6, deviceCode: 'esp32-acc-04', name: 'Puerta lobby', status: 'PROVISIONED'),
        ]);
    when(() => iot.getTelemetry(1)).thenAnswer((_) async => [iotTelemetry]);

    final cubit = build();
    await cubit.start();

    final s = cubit.state;
    expect(s.selectedBuildingId, 1, reason: '"Edificio Los Olivos" va antes que "Torre Mirador"');
    expect(s.status, LoadStatus.ready);
    expect(s.summary, (online: 1, offline: 1, maintenance: 1, provisioned: 1, decommissioned: 0));
    expect(s.devicesOf(1).map((d) => d.name), ['Puerta azotea', 'Puerta gimnasio', 'Puerta lobby', 'Puerta piscina']);
    expect(s.telemetryOf(iotDevice)?.latest, hasLength(2));
    expect(s.gatewayOf(iotDevice)?.name, 'Torre A');
    expect(s.telemetryUnavailable, isFalse);
  });

  test('si falla la telemetría, muestra los dispositivos igual y avisa', () async {
    when(() => iot.getDevices(1)).thenAnswer((_) async => [iotDevice]);
    when(() => iot.getTelemetry(1))
        .thenThrow(const ApiException(ApiErrorKind.server, 'El servidor tuvo un problema.', statusCode: 503));

    final cubit = build();
    await cubit.start();

    expect(cubit.state.status, LoadStatus.ready);
    expect(cubit.state.devices, hasLength(1));
    expect(cubit.state.telemetryUnavailable, isTrue);
  });

  test('contra la fake API (404) explica que el servicio IoT no existe ahí', () async {
    when(() => iot.getDevices(1)).thenThrow(const ApiException(ApiErrorKind.notFound, 'No se encontró', statusCode: 404));

    final cubit = build();
    await cubit.start();

    expect(cubit.state.status, LoadStatus.failure);
    expect(cubit.state.error, contains('API_BASE_URL'));
  });

  test('sin rol ADMIN (403) indica falta de permisos', () async {
    when(() => iot.getGateways(1)).thenThrow(const ApiException(ApiErrorKind.unauthorized, 'Forbidden', statusCode: 403));

    final cubit = build();
    await cubit.start();

    expect(cubit.state.error, contains('permisos de administrador'));
  });

  test('si falla la lista de edificios queda en error con el mensaje del servidor', () async {
    when(() => residential.getBuildings())
        .thenThrow(const ApiException(ApiErrorKind.network, 'No se pudo conectar con el servidor.'));

    final cubit = build();
    await cubit.start();

    expect(cubit.state.buildingsStatus, LoadStatus.failure);
    expect(cubit.state.error, 'No se pudo conectar con el servidor.');
    verifyNever(() => iot.getDevices(any()));
  });

  test('en vivo: recarga en silencio cada intervalo y marca la hora de actualización', () async {
    var t = DateTime(2026, 11, 2, 0, 20);
    var telemetryCalls = 0;
    when(() => iot.getDevices(1)).thenAnswer((_) async => [iotDevice]);
    when(() => iot.getTelemetry(1)).thenAnswer((_) async {
      telemetryCalls++;
      return [
        iotTelemetry.copyWith(latest: [
          SensorReading(magnitude: 'TEMPERATURE', value: 25.0 + telemetryCalls, unit: '°C'),
        ]),
      ];
    });

    final cubit = IotManagementCubit(iot: iot, residential: residential, now: () => t);
    await cubit.start();
    expect(cubit.state.updatedAt, t);
    expect(cubit.state.telemetryOf(iotDevice)?.latest.single.value, 26.0);

    final states = <IotManagementState>[];
    final sub = cubit.stream.listen(states.add);
    t = t.add(const Duration(seconds: 10));
    cubit.startAutoRefresh(const Duration(milliseconds: 20));
    await Future<void>.delayed(const Duration(milliseconds: 70));
    cubit.stopAutoRefresh();
    final callsWhenStopped = telemetryCalls;
    await Future<void>.delayed(const Duration(milliseconds: 60));
    await sub.cancel();

    expect(telemetryCalls, greaterThan(1));
    expect(telemetryCalls, callsWhenStopped, reason: 'detenido no vuelve a consultar');
    expect(cubit.state.telemetryOf(iotDevice)?.latest.single.value, greaterThan(26.0));
    expect(cubit.state.updatedAt, t);
    expect(states.any((s) => s.status == LoadStatus.loading), isFalse, reason: 'sin spinner en el refresco en vivo');
    await cubit.close();
  });

  test('cambiar de edificio descarta la respuesta tardía del anterior', () async {
    final slow = Completer<List<dynamic>>();
    when(() => iot.getDevices(1)).thenAnswer((_) async {
      await slow.future;
      return [iotDevice.copyWith(name: 'De Los Olivos')];
    });
    when(() => iot.getDevices(12)).thenAnswer((_) async => [iotDevice.copyWith(name: 'De Torre Mirador')]);

    final cubit = build();
    final starting = cubit.start(); // queda esperando el edificio 1
    await Future<void>.delayed(Duration.zero);
    await cubit.selectBuilding(12);
    slow.complete([]);
    await starting;

    expect(cubit.state.selectedBuildingId, 12);
    expect(cubit.state.devices.single.name, 'De Torre Mirador');
  });
}
