import 'dart:convert';

import 'package:edifika_mobile/app/app.dart';
import 'package:edifika_mobile/app/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'helpers/fake_http_adapter.dart';
import 'helpers/fakes.dart';
import 'helpers/memory_session_storage.dart';

/// App completa con sesión de ADMIN: router real, repositorios reales y HTTP
/// simulado con los ejemplos del contrato IoT.
void main() {
  setUpAll(() => initializeDateFormatting('es'));

  FakeHttpAdapter fakeApi() => FakeHttpAdapter({
        'GET /api/v1/residential/buildings': const FakeRoute(200, [
          {'idBuilding': 12, 'name': 'Torre Mirador', 'address': 'Av. Arequipa 100', 'district': 'Lince', 'city': 'Lima'},
        ]),
        'GET /api/v1/iot/gateways': const FakeRoute(200, [gatewayJson]),
        'GET /api/v1/iot/devices': const FakeRoute(200, [deviceJson]),
        'GET /api/v1/telemetry/devices': const FakeRoute(200, [telemetryJson]),
        // Resumen del Inicio del administrador
        'GET /api/v1/telemetry/alerts': const FakeRoute(200, []),
        'GET /api/v1/access/attempts': const FakeRoute(200, []),
      });

  Future<FakeHttpAdapter> launchWith(WidgetTester tester, FakeHttpAdapter api, {required List<String> roles}) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.reset);

    final session = MemorySessionStorage()
      ..token = 'fake-jwt-token-user-1'
      ..userJson = jsonEncode({
        'id': 1,
        'email': 'admin@edifika.com',
        'token': 'fake-jwt-token-user-1',
        'fullName': 'Ricardo Mendoza',
        'roles': roles,
      });
    await tester.pumpWidget(EdifikaApp(dependencies: AppDependencies.create(session: session, httpAdapter: api)));
    await tester.pumpAndSettle();
    if (roles.contains('ADMIN')) {
      // El administrador entra al Inicio (resumen) y desde ahí abre la Gestión IoT.
      expect(find.text('Alertas IoT abiertas'), findsOneWidget);
      api.requests.clear(); // los tests cuentan solo las llamadas de la Gestión IoT
      await tester.tap(find.widgetWithText(FilledButton, 'Gestión IoT'));
      await tester.pumpAndSettle();
    }
    return api;
  }

  Future<FakeHttpAdapter> launch(WidgetTester tester, {required List<String> roles}) =>
      launchWith(tester, fakeApi(), roles: roles);

  testWidgets('el administrador entra al Inicio y abre Gestión IoT, sin la barra del residente', (tester) async {
    await launch(tester, roles: ['ADMIN']);

    expect(find.text('Gestión IoT'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('Torre Mirador'), findsOneWidget);
    expect(find.text('Gateway · Torre A'), findsOneWidget);
    expect(find.text('Puerta piscina'), findsOneWidget);
    expect(find.text('En línea'), findsWidgets, reason: 'el estado va en texto, no solo en color');
    expect(find.text('Temperatura: 24.5 °C'), findsOneWidget);
  });

  testWidgets('consulta los servicios IoT filtrando por el edificio elegido', (tester) async {
    final api = await launch(tester, roles: ['ADMIN']);

    final iotCalls = api.requests.where((r) => r.uri.path.contains('/iot/') || r.uri.path.contains('/telemetry/'));
    // Gateways, dispositivos, telemetría y dispositivos nuevos
    expect(iotCalls, hasLength(4));
    expect(iotCalls.every((r) => r.queryParameters['buildingId'] == 12), isTrue);
  });

  testWidgets('tocar un dispositivo abre su detalle con acciones y se puede volver', (tester) async {
    await launch(tester, roles: ['ADMIN']);

    await tester.tap(find.text('Puerta piscina'));
    await tester.pumpAndSettle();

    expect(find.text('Reservar para mí'), findsOneWidget);
    expect(find.text('Color del LED'), findsWidgets);
    expect(find.text('Registrar tarjeta'), findsWidgets);
    expect(find.text('Lector RFID (RC522)'), findsOneWidget);
    expect(find.text('#00FF88'), findsWidgets);

    await tester.tap(find.byTooltip('Volver'));
    await tester.pumpAndSettle();
    expect(find.text('Gestión IoT'), findsOneWidget);
  });

  testWidgets('el administrador puede registrar una tarjeta RFID y asociarla a un residente', (tester) async {
    final api = await launch(tester, roles: ['ADMIN']);
    api.routes['POST /api/v1/iot/devices/3/enrollment'] = const FakeRoute(201, {
      'id': 9,
      'deviceId': 3,
      'deviceCode': 'esp32-acc-01',
      'buildingId': 12,
      'status': 'ACTIVE',
      'startedAt': '2026-11-02T06:00:00Z',
      'expiresAt': '2099-01-01T00:00:00Z',
    });
    api.routes['GET /api/v1/iot/devices/3/enrollment'] = const FakeRoute(200, {
      'id': 9,
      'deviceId': 3,
      'deviceCode': 'esp32-acc-01',
      'buildingId': 12,
      'status': 'CAPTURED',
      'startedAt': '2026-11-02T06:00:00Z',
      'expiresAt': '2099-01-01T00:00:00Z',
      'capturedUid': '04A1B2C3',
      'capturedAt': '2026-11-02T06:00:03Z',
    });
    api.routes['GET /api/v1/users'] = const FakeRoute(200, [
      {'id': 2, 'fullName': 'Ana Torres', 'email': 'ana@edifika.com', 'roles': ['TENANT']},
    ]);
    api.routes['GET /api/v1/residential/buildings/12/residents'] = const FakeRoute(200, [
      {'idUserUnit': 4, 'idUnit': 10, 'idUser': 2, 'status': 'ACTIVE'},
    ]);
    api.routes['POST /api/v1/access/credentials'] = const FakeRoute(201, {
      'id': 50,
      'rfidUid': '04A1B2C3',
      'buildingId': 12,
      'userId': 2,
      'holderName': 'Ana Torres',
      'status': 'ACTIVE',
      'origin': 'CLOUD',
    });

    await tester.tap(find.text('Puerta piscina'));
    await tester.pumpAndSettle();

    final registerButton = find.text('Registrar tarjeta').last;
    await tester.ensureVisible(registerButton);
    await tester.tap(registerButton);
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.textContaining('Esperando tarjeta en el lector'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('04A1B2C3'), findsOneWidget);
    expect(find.text('Ana Torres · ana@edifika.com · Inquilino'), findsOneWidget);

    final assignButton = find.text('Asociar');
    await tester.ensureVisible(assignButton);
    await tester.tap(assignButton);
    await tester.pumpAndSettle();

    expect(find.text('Tarjeta 04A1B2C3 registrada'), findsOneWidget);
    expect(find.text('Asociada a Ana Torres.'), findsOneWidget);
  });

  testWidgets('desde Tarjetas RFID lee una tarjeta en el lector y la asigna al propietario', (tester) async {
    final api = await launch(tester, roles: ['ADMIN']);
    const ownerCard = {
      'id': 50,
      'rfidUid': '04A1B2C3',
      'buildingId': 12,
      'userId': 4,
      'holderName': 'Propietario Demo',
      'status': 'ACTIVE',
      'origin': 'CLOUD',
    };
    api.routes['GET /api/v1/access/credentials'] = const FakeRoute(200, []);
    api.routes['GET /api/v1/users'] = const FakeRoute(200, [
      {'id': 1, 'fullName': 'Administrador Edifika', 'email': 'admin@edifika.com', 'roles': ['ADMIN']},
      {'id': 4, 'fullName': 'Propietario Demo', 'email': 'propietario@edifika.com', 'roles': ['OWNER']},
    ]);
    api.routes['GET /api/v1/residential/buildings/12/residents'] = const FakeRoute(200, []);
    api.routes['POST /api/v1/iot/devices/3/enrollment'] = const FakeRoute(201, {
      'id': 9,
      'deviceId': 3,
      'deviceCode': 'esp32-acc-01',
      'buildingId': 12,
      'status': 'ACTIVE',
      'startedAt': '2026-11-02T06:00:00Z',
      'expiresAt': '2099-01-01T00:00:00Z',
    });
    api.routes['GET /api/v1/iot/devices/3/enrollment'] = const FakeRoute(200, {
      'id': 9,
      'deviceId': 3,
      'deviceCode': 'esp32-acc-01',
      'buildingId': 12,
      'status': 'CAPTURED',
      'startedAt': '2026-11-02T06:00:00Z',
      'expiresAt': '2099-01-01T00:00:00Z',
      'capturedUid': '04A1B2C3',
      'capturedAt': '2026-11-02T06:00:03Z',
    });
    api.routes['POST /api/v1/access/credentials'] = const FakeRoute(201, ownerCard);

    await tester.tap(find.text('Tarjetas RFID'));
    await tester.pumpAndSettle();
    expect(find.textContaining('aún no tiene tarjetas'), findsOneWidget);

    // Un solo lector en línea: abre su detalle y entra solo en modo registro
    await tester.tap(find.text('Leer tarjeta en un lector'));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('04A1B2C3'), findsOneWidget);
    // El propietario queda elegido de entrada, no el administrador
    expect(find.text('Propietario Demo · propietario@edifika.com · Propietario'), findsOneWidget);

    final assignButton = find.text('Asociar');
    await tester.ensureVisible(assignButton);
    await tester.tap(assignButton);
    await tester.pumpAndSettle();
    expect(find.text('Asociada a Propietario Demo.'), findsOneWidget);

    // Al volver, la lista de tarjetas se recarga
    api.routes['GET /api/v1/access/credentials'] = const FakeRoute(200, [ownerCard]);
    await tester.scrollUntilVisible(find.byTooltip('Volver'), -300);
    await tester.tap(find.byTooltip('Volver'));
    await tester.pumpAndSettle();

    expect(find.text('Propietario Demo'), findsOneWidget);
    expect(find.text('UID 04A1B2C3'), findsOneWidget);
    expect(find.text('Activa'), findsOneWidget);
    final patch = api.requests.where((r) => r.method == 'POST' && r.uri.path == '/api/v1/access/credentials').single;
    expect(patch.data, containsPair('userId', 4));
  });

  testWidgets('un dispositivo identificado por el gateway se adopta desde el teléfono', (tester) async {
    const discovered = {
      'id': 4,
      'deviceCode': 'esp32-3c71bf',
      'gatewayId': 1,
      'gatewayCode': 'edge-gateway-01',
      'buildingId': 12,
      'mac': '24:6F:28:3C:71:BF',
      'firmware': 'v0.6.0',
      'model': 'door-node',
      'capabilities': ['RFID', 'LOCK', 'OLED'],
      'pairingCode': '4821',
      'status': 'PENDING',
      'firstSeenAt': '2026-11-03T15:04:05Z',
      'lastSeenAt': '2026-11-03T15:09:05Z',
    };
    final api = fakeApi()..routes['GET /api/v1/iot/discovered-devices'] = const FakeRoute(200, [discovered]);
    await launchWith(tester, api, roles: ['ADMIN']);
    api.routes['POST /api/v1/iot/discovered-devices/4/identify'] = const FakeRoute(202, null);
    api.routes['POST /api/v1/iot/discovered-devices/4/adopt'] =
        FakeRoute(201, {...deviceJson, 'id': 9, 'deviceCode': 'esp32-3c71bf', 'name': 'Puerta gimnasio', 'status': 'PROVISIONED'});

    expect(find.text('1 dispositivo nuevo'), findsOneWidget);
    await tester.tap(find.text('1 dispositivo nuevo'));
    await tester.pumpAndSettle();

    expect(find.text('Dispositivos nuevos'), findsOneWidget);
    expect(find.text('Código en pantalla: 4821'), findsOneWidget);
    await tester.tap(find.text('esp32-3c71bf'));
    await tester.pumpAndSettle();

    expect(find.text('Adoptar dispositivo'), findsOneWidget);
    expect(find.text('4821'), findsOneWidget);

    await tester.tap(find.text('Identificar (parpadea y suena)'));
    await tester.pumpAndSettle();
    expect(find.textContaining('parpadea en blanco'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5)); // el aviso se cierra solo y deja libre el botón
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Puerta gimnasio'), 'Puerta gimnasio');
    await tester.enterText(find.widgetWithText(TextField, 'Piso 2'), 'Piso 2');
    // Ya adoptado, el gateway deja de reportarlo
    api.routes['GET /api/v1/iot/discovered-devices'] = const FakeRoute(200, []);
    FocusManager.instance.primaryFocus?.unfocus(); // el campo con foco no vuelve a desplazar la vista
    await tester.pumpAndSettle();
    final adopt = find.text('Adoptar');
    await tester.ensureVisible(adopt);
    await tester.pumpAndSettle();
    await tester.tap(adopt);
    await tester.pumpAndSettle();

    final request = api.requests.lastWhere((r) => r.uri.path == '/api/v1/iot/discovered-devices/4/adopt');
    expect(request.data, {
      'name': 'Puerta gimnasio',
      'location': 'Piso 2',
      'deviceType': 'DOOR',
      'capabilities': ['RFID', 'LOCK', 'OLED'],
      'unlockSeconds': 5,
    });
    expect(find.text('Dispositivos nuevos'), findsOneWidget);
    expect(find.textContaining('No hay dispositivos esperando'), findsOneWidget);
  });

  testWidgets('un residente sigue entrando a sus pestañas, no a la gestión IoT', (tester) async {
    await launch(tester, roles: ['TENANT']);

    expect(find.text('Gestión IoT'), findsNothing);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
