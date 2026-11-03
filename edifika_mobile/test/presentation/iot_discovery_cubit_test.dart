import 'package:edifika_mobile/core/network/api_exception.dart';
import 'package:edifika_mobile/core/utils/load_status.dart';
import 'package:edifika_mobile/features/iot/domain/iot_models.dart';
import 'package:edifika_mobile/features/iot/presentation/iot_discovery_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fakes.dart';

void main() {
  late MockIotRepository iot;

  const pending = DiscoveredDevice(
    id: 4,
    deviceCode: 'esp32-3c71bf',
    gatewayId: 1,
    gatewayCode: 'edge-gateway-01',
    buildingId: 12,
    mac: '24:6F:28:3C:71:BF',
    firmware: 'v0.6.0',
    model: 'door-node',
    capabilities: ['RFID', 'LOCK', 'OLED'],
    pairingCode: '4821',
  );

  setUp(() => iot = MockIotRepository());

  group('lista de dispositivos nuevos', () {
    test('carga los pendientes del edificio', () async {
      when(() => iot.getDiscoveredDevices(12)).thenAnswer((_) async => [pending]);

      final cubit = IotDiscoveryCubit(iot, buildingId: 12);
      await cubit.load();

      expect(cubit.state.status, LoadStatus.ready);
      expect(cubit.state.devices.single.pairingCode, '4821');
    });

    test('un error al cargar se muestra en pantalla', () async {
      when(() => iot.getDiscoveredDevices(12))
          .thenThrow(const ApiException(ApiErrorKind.unauthorized, 'No autorizado'));

      final cubit = IotDiscoveryCubit(iot, buildingId: 12);
      await cubit.load();

      expect(cubit.state.status, LoadStatus.failure);
      expect(cubit.state.error, 'No autorizado');
    });
  });

  group('adopción', () {
    test('identificar avisa que la placa parpadea', () async {
      when(() => iot.identifyDiscoveredDevice(4)).thenAnswer((_) async {});

      final cubit = IotAdoptCubit(iot, discovered: pending);
      await cubit.identify();

      verify(() => iot.identifyDiscoveredDevice(4)).called(1);
      expect(cubit.state.busy, isFalse);
      expect(cubit.state.message, contains('parpadea'));
    });

    test('adoptar envía los datos y devuelve el dispositivo creado', () async {
      when(() => iot.adoptDiscoveredDevice(
            4,
            name: 'Puerta gimnasio',
            location: 'Piso 2',
            capabilities: ['RFID', 'LOCK'],
            unlockSeconds: 5,
          )).thenAnswer((_) async => iotDevice.copyWith(id: 9, deviceCode: 'esp32-3c71bf', name: 'Puerta gimnasio'));

      final cubit = IotAdoptCubit(iot, discovered: pending);
      await cubit.adopt(name: ' Puerta gimnasio ', location: 'Piso 2', capabilities: ['RFID', 'LOCK'], unlockSeconds: 5);

      expect(cubit.state.adopted?.id, 9);
      expect(cubit.state.error, isNull);
    });

    test('sin nombre, ubicación o componentes no llama al backend', () async {
      final cubit = IotAdoptCubit(iot, discovered: pending);

      await cubit.adopt(name: '', location: 'Piso 2', capabilities: ['RFID'], unlockSeconds: 5);
      expect(cubit.state.error, 'Completa el nombre y la ubicación.');

      await cubit.adopt(name: 'Puerta', location: 'Piso 2', capabilities: [], unlockSeconds: 5);
      expect(cubit.state.error, 'Elige al menos un componente.');

      verifyNever(() => iot.adoptDiscoveredDevice(any(),
          name: any(named: 'name'),
          location: any(named: 'location'),
          capabilities: any(named: 'capabilities'),
          unlockSeconds: any(named: 'unlockSeconds')));
    });

    test('si el backend rechaza la adopción muestra el motivo', () async {
      when(() => iot.adoptDiscoveredDevice(any(),
              name: any(named: 'name'),
              location: any(named: 'location'),
              capabilities: any(named: 'capabilities'),
              unlockSeconds: any(named: 'unlockSeconds')))
          .thenThrow(const ApiException(ApiErrorKind.conflict, 'El dispositivo descubierto ya no está pendiente'));

      final cubit = IotAdoptCubit(iot, discovered: pending);
      await cubit.adopt(name: 'Puerta', location: 'Piso 2', capabilities: ['RFID'], unlockSeconds: 5);

      expect(cubit.state.adopted, isNull);
      expect(cubit.state.error, 'El dispositivo descubierto ya no está pendiente');
    });

    test('ignorar lo marca como resuelto', () async {
      when(() => iot.ignoreDiscoveredDevice(4)).thenAnswer((_) async {});

      final cubit = IotAdoptCubit(iot, discovered: pending);
      await cubit.ignore();

      expect(cubit.state.ignored, isTrue);
    });
  });
}
