import 'package:edifika_mobile/core/network/api_exception.dart';
import 'package:edifika_mobile/features/iot/domain/iot_models.dart';
import 'package:edifika_mobile/features/iot/presentation/iot_device_control_cubit.dart';
import 'package:edifika_mobile/features/profile/domain/user_profile.dart';
import 'package:edifika_mobile/features/residential/domain/residential_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fakes.dart';

void main() {
  late MockIotRepository iot;
  late MockProfileRepository profile;
  late MockResidentialRepository residential;
  final now = DateTime.utc(2026, 11, 1, 23, 30);
  final freeDoor = iotDevice.copyWith(accessMode: 'FREE_ACCESS', activeReservationId: null, ledColor: null);
  final reservedDoor = iotDevice.copyWith(accessMode: 'RESERVED', activeReservationId: 100, ledColor: '#800080');

  DeviceCommand command(String status, {String? detail}) =>
      DeviceCommand(commandId: 'abc', deviceId: 3, type: 'SET_LED', params: {'color': '#FFFF00'}, status: status, detail: detail);

  IotDeviceControlCubit build(IotDevice device) => IotDeviceControlCubit(
        iot,
        profile: profile,
        residential: residential,
        device: device,
        now: () => now,
        pollInterval: Duration.zero,
      );

  setUpAll(() => registerFallbackValue(DateTime(2026)));
  setUp(() {
    iot = MockIotRepository();
    profile = MockProfileRepository();
    residential = MockResidentialRepository();
  });

  group('reservar para mí', () {
    test('reserva desde ahora por 10 minutos y refleja la puerta reservada', () async {
      final reservation = DoorReservation(
        id: 100,
        deviceId: 3,
        holderUserId: 1,
        startsAt: now.toIso8601String(),
        endsAt: now.add(const Duration(minutes: 10)).toIso8601String(),
        status: 'ACTIVE',
      );
      when(() => iot.createReservation(3, startsAt: any(named: 'startsAt'), endsAt: any(named: 'endsAt')))
          .thenAnswer((_) async => reservation);
      when(() => iot.getDevice(3)).thenAnswer((_) async => reservedDoor);

      final cubit = build(freeDoor);
      await cubit.reserveForMe(const Duration(minutes: 10));

      verify(() => iot.createReservation(3, startsAt: now, endsAt: now.add(const Duration(minutes: 10)))).called(1);
      expect(cubit.state.reservation, reservation);
      expect(cubit.state.isReserved, isTrue);
      expect(cubit.state.canSetLed, isTrue);
      expect(cubit.state.reserving, isFalse);
    });

    test('si la reserva queda SCHEDULED, consulta la puerta hasta que figure reservada', () async {
      var calls = 0;
      when(() => iot.createReservation(3, startsAt: any(named: 'startsAt'), endsAt: any(named: 'endsAt'))).thenAnswer(
        (_) async => DoorReservation(
          id: 101,
          deviceId: 3,
          holderUserId: 1,
          startsAt: now.toIso8601String(),
          endsAt: now.add(const Duration(minutes: 10)).toIso8601String(),
          status: 'SCHEDULED',
        ),
      );
      // Primera lectura: aún libre (el servidor activa la reserva un instante después).
      when(() => iot.getDevice(3)).thenAnswer((_) async => ++calls < 3 ? freeDoor : reservedDoor.copyWith(activeReservationId: 101));

      final cubit = build(freeDoor);
      await cubit.reserveForMe(const Duration(minutes: 10));

      expect(calls, 3);
      expect(cubit.state.isReserved, isTrue);
      expect(cubit.hasPendingReservation, isTrue);
      expect(cubit.state.canSetLed, isTrue);
    });

    test('muestra el mensaje del backend si la puerta ya está reservada (409)', () async {
      when(() => iot.createReservation(3, startsAt: any(named: 'startsAt'), endsAt: any(named: 'endsAt'))).thenThrow(
          const ApiException(ApiErrorKind.conflict, 'La puerta ya está reservada en ese horario', statusCode: 409));

      final cubit = build(freeDoor);
      await cubit.reserveForMe(const Duration(minutes: 10));

      expect(cubit.state.message, 'La puerta ya está reservada en ese horario');
      expect(cubit.state.reservation, isNull);
    });
  });

  group('en vivo', () {
    test('refreshLive trae el estado y las últimas lecturas del dispositivo', () async {
      when(() => iot.getDevice(3)).thenAnswer((_) async => freeDoor.copyWith(lastSeenAt: '2026-11-01T23:31:00Z'));
      when(() => iot.getDeviceTelemetry('esp32-acc-01')).thenAnswer((_) async => iotTelemetry.copyWith(latest: [
            const SensorReading(magnitude: 'TEMPERATURE', value: 26.5, unit: '°C', capturedAt: '2026-11-01T23:30:58Z'),
          ]));

      final cubit = build(freeDoor);
      await cubit.refreshLive();

      expect(cubit.state.telemetry?.latest.single.value, 26.5);
      expect(cubit.state.device.lastSeenAt, '2026-11-01T23:31:00Z');
      expect(cubit.state.updatedAt, now);
    });

    test('si falla la telemetría conserva las últimas lecturas conocidas', () async {
      when(() => iot.getDevice(3)).thenAnswer((_) async => freeDoor);
      when(() => iot.getDeviceTelemetry('esp32-acc-01'))
          .thenThrow(const ApiException(ApiErrorKind.server, 'Error', statusCode: 503));

      final cubit = IotDeviceControlCubit(iot, device: freeDoor, telemetry: iotTelemetry, now: () => now);
      await cubit.refreshLive();

      expect(cubit.state.telemetry, iotTelemetry);
    });

    test('se actualiza solo cada intervalo hasta que se detiene', () async {
      var calls = 0;
      when(() => iot.getDevice(3)).thenAnswer((_) async => freeDoor);
      when(() => iot.getDeviceTelemetry('esp32-acc-01')).thenAnswer((_) async {
        calls++;
        return iotTelemetry;
      });

      final cubit = build(freeDoor)..startAutoRefresh(const Duration(milliseconds: 20));
      await Future<void>.delayed(const Duration(milliseconds: 70));
      await cubit.close();
      final callsAtClose = calls;
      await Future<void>.delayed(const Duration(milliseconds: 60));

      expect(callsAtClose, greaterThan(1));
      expect(calls, callsAtClose, reason: 'al cerrar la pantalla deja de consultar');
    });
  });

  group('color del LED', () {
    test('sin reserva no se puede enviar (el LED solo se enciende reservado)', () async {
      final cubit = build(freeDoor);
      await cubit.setLedColor('#FFFF00');

      expect(cubit.state.canSetLed, isFalse);
      verifyNever(() => iot.setLedColor(any(), any()));
    });

    test('envía amarillo, espera la confirmación del nodo y queda aplicado', () async {
      var polls = 0;
      when(() => iot.setLedColor(3, '#FFFF00')).thenAnswer((_) async => command('PENDING'));
      when(() => iot.getCommand('abc')).thenAnswer((_) async => ++polls < 2 ? command('PENDING') : command('OK'));
      when(() => iot.getDevice(3)).thenAnswer((_) async => reservedDoor.copyWith(ledColor: '#FFFF00'));

      final cubit = build(reservedDoor);
      final states = <IotDeviceControlState>[];
      final sub = cubit.stream.listen(states.add);
      await cubit.setLedColor('#FFFF00');
      await Future<void>.delayed(Duration.zero); // el stream entrega el último estado de forma asíncrona
      await sub.cancel();

      expect(states.map((s) => s.ledStatus),
          containsAllInOrder([LedCommandStatus.sending, LedCommandStatus.waiting, LedCommandStatus.applied]));
      expect(polls, 2);
      expect(cubit.state.device.ledColor, '#FFFF00');
    });

    test('si el nodo rechaza el comando muestra el motivo', () async {
      when(() => iot.setLedColor(3, '#FFFF00')).thenAnswer((_) async => command('PENDING'));
      when(() => iot.getCommand('abc')).thenAnswer((_) async => command('FAILED', detail: 'not reserved'));
      when(() => iot.getDevice(3)).thenAnswer((_) async => reservedDoor);

      final cubit = build(reservedDoor);
      await cubit.setLedColor('#FFFF00');

      expect(cubit.state.ledStatus, LedCommandStatus.rejected);
      expect(cubit.state.ledError, contains('no está reservada'));
    });

    test('si el nodo no responde, avisa que no confirmó a tiempo', () async {
      var t = now;
      when(() => iot.setLedColor(3, '#FFFF00')).thenAnswer((_) async => command('PENDING'));
      when(() => iot.getCommand('abc')).thenAnswer((_) async {
        t = t.add(const Duration(seconds: 5));
        return command('PENDING');
      });
      when(() => iot.getDevice(3)).thenAnswer((_) async => reservedDoor);

      final cubit = IotDeviceControlCubit(iot, device: reservedDoor, now: () => t, pollInterval: Duration.zero);
      await cubit.setLedColor('#FFFF00');

      expect(cubit.state.ledStatus, LedCommandStatus.rejected);
      expect(cubit.state.ledError, contains('no confirmó'));
    });

    test('un 409 del backend (puerta no reservada) se muestra tal cual', () async {
      when(() => iot.setLedColor(3, '#FFFF00'))
          .thenThrow(const ApiException(ApiErrorKind.conflict, 'La puerta no está reservada', statusCode: 409));

      final cubit = build(reservedDoor);
      await cubit.setLedColor('#FFFF00');

      expect(cubit.state.ledError, 'La puerta no está reservada');
    });
  });

  group('registrar tarjeta RFID', () {
    const ana = UserProfile(id: 2, fullName: 'Ana Torres', email: 'ana@edifika.com');
    const carlos = UserProfile(id: 3, fullName: 'Carlos Ruiz', email: 'carlos@edifika.com');

    CardEnrollment session({
      String status = 'ACTIVE',
      String? capturedUid,
      ExistingCardCredential? existingCredential,
    }) =>
        CardEnrollment(
          id: 9,
          deviceId: 3,
          deviceCode: 'esp32-acc-01',
          buildingId: 12,
          status: status,
          startedAt: now.toIso8601String(),
          expiresAt: now.add(const Duration(seconds: 60)).toIso8601String(),
          capturedUid: capturedUid,
          capturedAt: capturedUid == null ? null : now.add(const Duration(seconds: 4)).toIso8601String(),
          existingCredential: existingCredential,
        );

    setUp(() {
      when(() => profile.getUsers()).thenAnswer((_) async => const [ana, carlos]);
      when(() => residential.getBuildingResidents(12))
          .thenAnswer((_) async => const [UserUnit(id: 1, idUnit: 10, idUser: 2, status: 'ACTIVE')]);
    });

    test('activa modo registro, captura la tarjeta y la asocia al residente del edificio', () async {
      var polls = 0;
      when(() => iot.startEnrollment(3)).thenAnswer((_) async => session());
      when(() => iot.getEnrollment(3)).thenAnswer(
        (_) async => ++polls < 2 ? session() : session(status: 'CAPTURED', capturedUid: '04A1B2C3'),
      );
      when(() => iot.createCredential(
            rfidUid: '04A1B2C3',
            buildingId: 12,
            userId: 2,
            holderName: 'Ana Torres',
          )).thenAnswer(
        (_) async => const AccessCredential(
          id: 50,
          rfidUid: '04A1B2C3',
          buildingId: 12,
          userId: 2,
          holderName: 'Ana Torres',
          status: 'ACTIVE',
        ),
      );

      final cubit = build(freeDoor);
      await cubit.startEnrollment();

      expect(cubit.state.enrollment?.isCaptured, isTrue);
      expect(cubit.state.enrollment?.capturedUid, '04A1B2C3');
      // Primero los residentes del edificio y después el resto de usuarios
      expect(cubit.state.residents.map((r) => r.fullName), ['Ana Torres', 'Carlos Ruiz']);
      expect(cubit.state.selectedResidentId, 2);
      expect(cubit.state.canAssignCard, isTrue);

      await cubit.assignCapturedCard();

      expect(cubit.state.createdCredential?.rfidUid, '04A1B2C3');
      expect(cubit.state.enrollment, isNull);
      expect(cubit.state.message, 'Tarjeta asociada a Ana Torres.');
    });

    test('si la tarjeta ya pertenece a alguien, no permite duplicarla', () async {
      when(() => iot.startEnrollment(3)).thenAnswer((_) async => session());
      when(() => iot.getEnrollment(3)).thenAnswer(
        (_) async => session(
          status: 'CAPTURED',
          capturedUid: '04A1B2C3',
          existingCredential: const ExistingCardCredential(id: 7, userId: 3, holderName: 'Carlos Ruiz', status: 'ACTIVE'),
        ),
      );

      final cubit = build(freeDoor);
      await cubit.startEnrollment();

      expect(cubit.state.enrollment?.existingCredential?.holderName, 'Carlos Ruiz');
      expect(cubit.state.canAssignCard, isFalse);
    });

    test('una tarjeta revocada se puede reasignar a otro usuario', () async {
      when(() => iot.startEnrollment(3)).thenAnswer((_) async => session());
      when(() => iot.getEnrollment(3)).thenAnswer(
        (_) async => session(
          status: 'CAPTURED',
          capturedUid: '04A1B2C3',
          existingCredential: const ExistingCardCredential(id: 7, userId: 3, holderName: 'Carlos Ruiz', status: 'REVOKED'),
        ),
      );

      final cubit = build(freeDoor);
      await cubit.startEnrollment();

      expect(cubit.state.canAssignCard, isTrue);
    });

    test('elige de entrada al propietario, no al administrador', () async {
      const admin = UserProfile(id: 1, fullName: 'Administrador Edifika', email: 'admin@edifika.com', roles: ['ADMIN']);
      const owner = UserProfile(id: 4, fullName: 'Propietario Demo', email: 'propietario@edifika.com', roles: ['OWNER']);
      when(() => profile.getUsers()).thenAnswer((_) async => const [admin, owner]);
      when(() => residential.getBuildingResidents(12)).thenAnswer((_) async => const []);
      when(() => iot.startEnrollment(3)).thenAnswer((_) async => session());
      when(() => iot.getEnrollment(3)).thenAnswer((_) async => session(status: 'CAPTURED', capturedUid: '04A1B2C3'));

      final cubit = build(freeDoor);
      await cubit.startEnrollment();

      expect(cubit.state.residents.map((r) => r.id), [1, 4]);
      expect(cubit.state.selectedResidentId, 4);
    });

    test('startEnrollmentIf activa el modo registro solo si se pidió', () async {
      when(() => iot.startEnrollment(3)).thenAnswer((_) async => session(status: 'EXPIRED'));
      final cubit = build(freeDoor);

      cubit.startEnrollmentIf(false);
      verifyNever(() => iot.startEnrollment(3));

      cubit.startEnrollmentIf(true);
      await Future<void>.delayed(Duration.zero);
      verify(() => iot.startEnrollment(3)).called(1);
    });

    test('cancelar envía DELETE y limpia la sesión de registro', () async {
      when(() => iot.cancelEnrollment(3)).thenAnswer((_) async {});
      final cubit = build(freeDoor);
      cubit.emit(cubit.state.copyWith(enrollment: session(), enrollmentSecondsLeft: 45));

      await cubit.cancelEnrollment();

      verify(() => iot.cancelEnrollment(3)).called(1);
      expect(cubit.state.enrollment, isNull);
      expect(cubit.state.enrollmentSecondsLeft, 0);
    });
  });
}
