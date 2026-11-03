import 'package:edifika_mobile/core/network/api_client.dart';
import 'package:edifika_mobile/core/network/api_exception.dart';
import 'package:edifika_mobile/features/iot/data/iot_repository_impl.dart';
import 'package:edifika_mobile/features/residential/data/residential_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_http_adapter.dart';
import '../helpers/fakes.dart';
import '../helpers/memory_session_storage.dart';

/// Repositorio IoT contra los ejemplos del contrato (Edifika-IoT-Platform/contracts).
void main() {
  late FakeHttpAdapter adapter;
  late IotRepositoryImpl repository;
  late ResidentialRepositoryImpl residential;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET /api/v1/iot/gateways': const FakeRoute(200, [gatewayJson]),
      'GET /api/v1/iot/devices': const FakeRoute(200, [deviceJson]),
      'GET /api/v1/telemetry/devices': const FakeRoute(200, [telemetryJson]),
      // Forma real de Residential Management: `idBuilding`, sin `id`.
      'GET /api/v1/residential/buildings': const FakeRoute(200, [
        {'idBuilding': 12, 'name': 'Torre Mirador', 'address': 'Av. Arequipa 100', 'district': 'Lince', 'city': 'Lima'},
      ]),
    });
    final dio = createApiClient(session: MemorySessionStorage(), onUnauthorized: () {}, baseUrl: 'http://test/api/v1')
      ..httpClientAdapter = adapter;
    repository = IotRepositoryImpl(dio);
    residential = ResidentialRepositoryImpl(dio);
  });

  test('gateways del edificio: filtra por buildingId y parsea GatewayResource', () async {
    final gateways = await repository.getGateways(12);

    expect(adapter.requests.single.queryParameters, {'buildingId': 12});
    expect(gateways.single.gatewayCode, 'edge-gateway-01');
    expect(gateways.single.status, 'ONLINE');
    expect(gateways.single.syncVersion, 42);
  });

  test('dispositivos del edificio: parsea DeviceResource completo', () async {
    final device = (await repository.getDevices(12)).single;

    expect(adapter.requests.single.uri.path, '/api/v1/iot/devices');
    expect(adapter.requests.single.queryParameters, {'buildingId': 12});
    expect(device.deviceCode, 'esp32-acc-01');
    expect(device.gatewayId, 1);
    expect(device.capabilities, contains('RFID'));
    expect(device.accessMode, 'RESERVED');
    expect(device.activeReservationId, 7);
    expect(device.ledColor, '#00FF88');
    expect(device.status, 'ACTIVE');
  });

  test('telemetría del edificio: últimas lecturas de temperatura y humedad', () async {
    final telemetry = (await repository.getTelemetry(12)).single;

    expect(telemetry.connectionStatus, 'ACTIVE');
    expect(telemetry.latest.map((r) => r.magnitude), ['TEMPERATURE', 'HUMIDITY']);
    expect(telemetry.latest.first.value, 24.5);
  });

  test('acepta un dispositivo recién provisionado (campos opcionales en null)', () async {
    adapter.routes['GET /api/v1/iot/devices'] = FakeRoute(200, [
      {
        ...deviceJson,
        'activeReservationId': null,
        'ledColor': null,
        'firmwareVersion': null,
        'lastSeenAt': null,
        'status': 'PROVISIONED',
      },
    ]);

    final device = (await repository.getDevices(12)).single;

    expect(device.status, 'PROVISIONED');
    expect(device.lastSeenAt, isNull);
    expect(device.firmwareVersion, isNull);
  });

  test('403 de un usuario sin rol ADMIN se traduce a ApiException', () async {
    adapter.routes['GET /api/v1/iot/devices'] = const FakeRoute(403, {'message': 'Acceso denegado'});

    expect(
      () => repository.getDevices(12),
      throwsA(isA<ApiException>().having((e) => e.kind, 'kind', ApiErrorKind.unauthorized)),
    );
  });

  test('reserva: POST con el rango en UTC y sin holderUserId (queda a nombre del usuario)', () async {
    adapter.routes['POST /api/v1/iot/devices/3/reservations'] = const FakeRoute(201, {
      'id': 7,
      'deviceId': 3,
      'holderUserId': 15,
      'startsAt': '2026-10-23T20:00:00Z',
      'endsAt': '2026-10-23T20:10:00Z',
      'status': 'ACTIVE',
      'authorizedUserIds': [],
      'createdBy': 15,
      'createdAt': '2026-10-23T20:00:00Z',
    });

    final reservation = await repository.createReservation(
      3,
      startsAt: DateTime.utc(2026, 10, 23, 20, 0, 0, 123),
      endsAt: DateTime.utc(2026, 10, 23, 20, 10),
    );

    expect(adapter.requests.single.data, {'startsAt': '2026-10-23T20:00:00.000Z', 'endsAt': '2026-10-23T20:10:00.000Z'});
    expect(reservation.id, 7);
    expect(reservation.status, 'ACTIVE');
  });

  test('LED: PUT con el color y devuelve el comando PENDING; luego se consulta su estado', () async {
    const pending = {
      'commandId': '5b0e0000000000000000000000000001',
      'deviceId': 3,
      'type': 'SET_LED',
      'params': {'color': '#FFFF00'},
      'status': 'PENDING',
      'detail': null,
      'requestedBy': 15,
      'requestedAt': '2026-10-23T15:00:00Z',
      'expiresAt': '2026-10-23T15:00:10Z',
      'resolvedAt': null,
    };
    adapter.routes['PUT /api/v1/iot/devices/3/led'] = const FakeRoute(202, pending);
    adapter.routes['GET /api/v1/iot/device-commands/5b0e0000000000000000000000000001'] =
        FakeRoute(200, {...pending, 'status': 'OK', 'resolvedAt': '2026-10-23T15:00:01Z'});

    final command = await repository.setLedColor(3, '#FFFF00');
    final resolved = await repository.getCommand(command.commandId);

    expect(adapter.requests.first.data, {'color': '#FFFF00'});
    expect(command.isPending, isTrue);
    expect(resolved.status, 'OK');
  });

  test('modo registro: inicia, consulta tarjeta capturada, cancela y crea credencial', () async {
    const activeEnrollment = {
      'id': 9,
      'deviceId': 3,
      'deviceCode': 'esp32-acc-01',
      'buildingId': 12,
      'status': 'ACTIVE',
      'startedAt': '2026-11-02T06:00:00Z',
      'expiresAt': '2026-11-02T06:01:00Z',
      'capturedUid': null,
      'capturedAt': null,
      'existingCredential': null,
    };
    adapter.routes['POST /api/v1/iot/devices/3/enrollment'] = const FakeRoute(201, activeEnrollment);
    adapter.routes['GET /api/v1/iot/devices/3/enrollment'] = FakeRoute(200, {
      ...activeEnrollment,
      'status': 'CAPTURED',
      'capturedUid': '04A1B2C3',
      'capturedAt': '2026-11-02T06:00:05Z',
      'existingCredential': {
        'id': 5,
        'userId': 2,
        'holderName': 'Ana Torres',
        'status': 'ACTIVE',
      },
    });
    adapter.routes['DELETE /api/v1/iot/devices/3/enrollment'] = const FakeRoute(204, null);
    adapter.routes['POST /api/v1/access/credentials'] = const FakeRoute(201, {
      'id': 11,
      'rfidUid': '04A1B2C3',
      'buildingId': 12,
      'userId': 2,
      'holderName': 'Ana Torres',
      'status': 'ACTIVE',
      'origin': 'CLOUD',
    });

    final started = await repository.startEnrollment(3);
    final captured = await repository.getEnrollment(3);
    await repository.cancelEnrollment(3);
    final credential = await repository.createCredential(
      rfidUid: '04A1B2C3',
      buildingId: 12,
      userId: 2,
      holderName: 'Ana Torres',
    );

    expect(started.isActive, isTrue);
    expect(captured?.isCaptured, isTrue);
    expect(captured?.capturedUid, '04A1B2C3');
    expect(captured?.existingCredential?.holderName, 'Ana Torres');
    expect(credential.id, 11);
    expect(credential.rfidUid, '04A1B2C3');
    expect(adapter.requests.last.data, {
      'rfidUid': '04A1B2C3',
      'buildingId': 12,
      'userId': 2,
      'holderName': 'Ana Torres',
    });
  });

  test('edificios y residentes: lee `idBuilding` e `idUserUnit` del microservicio Residential Management', () async {
    adapter.routes['GET /api/v1/residential/buildings/12/residents'] = const FakeRoute(200, [
      {
        'idUserUnit': 4,
        'idUnit': 10,
        'idUser': 2,
        'startDate': '2026-11-01T00:00:00',
        'endDate': null,
        'status': 'ACTIVE',
      },
    ]);

    final buildings = await residential.getBuildings();
    final residents = await residential.getBuildingResidents(12);

    expect(buildings.single.id, 12);
    expect(buildings.single.name, 'Torre Mirador');
    expect(residents.single.id, 4);
    expect(residents.single.idUser, 2);
    expect(residents.single.isActive, isTrue);
  });

  test('tarjetas del edificio y cambio de estado', () async {
    const credential = {
      'id': 11,
      'rfidUid': '04A1B2C3',
      'buildingId': 12,
      'userId': 2,
      'holderName': 'Ana Torres',
      'status': 'ACTIVE',
      'origin': 'CLOUD',
    };
    adapter.routes['GET /api/v1/access/credentials'] = const FakeRoute(200, [credential]);
    adapter.routes['PATCH /api/v1/access/credentials/11/status'] = FakeRoute(200, {...credential, 'status': 'SUSPENDED'});

    final list = await repository.getCredentials(12);
    final updated = await repository.changeCredentialStatus(11, 'SUSPENDED');

    expect(adapter.requests.first.queryParameters, {'buildingId': 12});
    expect(list.single.holderName, 'Ana Torres');
    expect(adapter.requests.last.data, {'status': 'SUSPENDED'});
    expect(updated.status, 'SUSPENDED');
  });

  test('dispositivos descubiertos: listar, identificar, adoptar e ignorar', () async {
    const discovered = {
      'id': 4,
      'deviceCode': 'esp32-3c71bf',
      'gatewayId': 1,
      'gatewayCode': 'edge-gateway-01',
      'buildingId': 12,
      'mac': '24:6F:28:3C:71:BF',
      'firmware': 'v0.6.0',
      'model': 'door-node',
      'capabilities': ['RFID', 'LOCK'],
      'ip': '192.168.1.40',
      'rssi': -58,
      'pairingCode': '4821',
      'status': 'PENDING',
      'deviceId': null,
      'firstSeenAt': '2026-11-03T15:04:05Z',
      'lastSeenAt': '2026-11-03T15:09:05Z',
    };
    adapter.routes['GET /api/v1/iot/discovered-devices'] = const FakeRoute(200, [discovered]);
    adapter.routes['POST /api/v1/iot/discovered-devices/4/identify'] = const FakeRoute(202, null);
    adapter.routes['POST /api/v1/iot/discovered-devices/4/adopt'] = FakeRoute(201, {...deviceJson, 'id': 9, 'deviceCode': 'esp32-3c71bf'});
    adapter.routes['POST /api/v1/iot/discovered-devices/4/ignore'] = FakeRoute(200, {...discovered, 'status': 'IGNORED'});

    final list = await repository.getDiscoveredDevices(12);
    await repository.identifyDiscoveredDevice(4);
    final device = await repository.adoptDiscoveredDevice(4,
        name: 'Puerta gimnasio', location: 'Piso 2', capabilities: ['RFID', 'LOCK'], unlockSeconds: 5);
    await repository.ignoreDiscoveredDevice(4);

    expect(adapter.requests[0].queryParameters, {'buildingId': 12});
    expect(list.single.pairingCode, '4821');
    expect(list.single.capabilities, ['RFID', 'LOCK']);
    expect(adapter.requests[1].data, {'seconds': 10});
    expect(adapter.requests[2].data, {
      'name': 'Puerta gimnasio',
      'location': 'Piso 2',
      'deviceType': 'DOOR',
      'capabilities': ['RFID', 'LOCK'],
      'unlockSeconds': 5,
    });
    expect(device.id, 9);
  });
}
