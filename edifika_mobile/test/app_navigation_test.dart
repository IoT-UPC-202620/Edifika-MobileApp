import 'dart:convert';

import 'package:edifika_mobile/app/app.dart';
import 'package:edifika_mobile/app/app_dependencies.dart';
import 'package:edifika_mobile/core/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'helpers/fake_http_adapter.dart';
import 'helpers/memory_session_storage.dart';

/// Recorre la app completa (router real, repositorios reales, HTTP simulado
/// con respuestas de db.json) para verificar la navegación entre pestañas.
void main() {
  setUpAll(() => initializeDateFormatting('es'));

  final inThreeDays = Formatters.apiDate(DateTime.now().add(const Duration(days: 3)));

  FakeHttpAdapter fakeApi() => FakeHttpAdapter({
        'GET /api/v1/residential/buildings/1': const FakeRoute(200, {'id': 1, 'name': 'Edificio Los Olivos'}),
        'GET /api/v1/residential/residents/me': const FakeRoute(200, {
          'buildingId': 1,
          'buildingName': 'Edificio Los Olivos',
          'unitId': 2,
          'unitNumber': 102,
          'relationType': 'OWNER',
        }),
        'GET /api/v1/residential/units/2': const FakeRoute(200, {'id': 2, 'idBuilding': 1, 'unitNumber': 102, 'floor': 1}),
        'GET /api/v1/payments/debts/unit/2': const FakeRoute(200, [
          {'id': 1, 'unitId': 2, 'description': 'Maintenance fee October', 'amount': 850, 'currency': 'PEN', 'dueDate': '2026-06-30', 'status': 'PENDING'},
        ]),
        'GET /api/v1/common-areas': const FakeRoute(200, [
          {'id': 1, 'name': 'Piscina principal Mayor', 'type': 'POOL', 'status': 'AVAILABLE', 'maxCapacity': 11},
        ]),
        'GET /api/v1/reservations': FakeRoute(200, [
          {'id': 4, 'residentId': 2, 'commonAreaId': 1, 'reservationDate': inThreeDays, 'timeSlot': 10, 'status': 'ACTIVE'},
        ]),
        'GET /api/v1/notifications/user/2': const FakeRoute(200, {'content': []}),
        'GET /api/v1/posts': const FakeRoute(200, {
          'content': [
            {'id': 1, 'title': 'Mantenimiento del ascensor', 'content': '¿Terminará hoy?', 'residentId': 2, 'createdAt': '2026-06-22T14:15:00'},
          ],
        }),
        'GET /api/v1/users': const FakeRoute(200, [
          {'id': 2, 'fullName': 'Residente Demo', 'email': 'resident@edifika.com'},
        ]),
      });

  Future<void> launchSignedIn(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.reset);

    final session = MemorySessionStorage()
      ..token = 'fake-jwt-token-resident'
      ..userJson = jsonEncode({
        'id': 2,
        'email': 'resident@edifika.com',
        'token': 'fake-jwt-token-resident',
        'fullName': 'Residente Demo',
        'roles': ['TENANT'],
        'buildingId': 1,
      });
    await tester.pumpWidget(EdifikaApp(dependencies: AppDependencies.create(session: session, httpAdapter: fakeApi())));
    await tester.pumpAndSettle();
  }

  Finder tab(String label) => find.descendant(of: find.byType(NavigationBar), matching: find.text(label));

  testWidgets('una sesión guardada abre Inicio con la próxima reserva', (tester) async {
    await launchSignedIn(tester);

    expect(find.text('Hola, Residente Demo'), findsOneWidget);
    expect(find.text('Piscina principal Mayor'), findsOneWidget);
  });

  testWidgets('cada pestaña abre su pantalla', (tester) async {
    await launchSignedIn(tester);

    await tester.tap(tab('Comunidad'));
    await tester.pumpAndSettle();
    expect(find.text('Comunidades'), findsOneWidget);

    await tester.tap(tab('Cuenta'));
    await tester.pumpAndSettle();
    expect(find.text('Mis deudas'), findsOneWidget);

    await tester.tap(tab('Anuncios'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Pendiente de integración'), findsOneWidget);

    await tester.tap(tab('Reservas'));
    await tester.pumpAndSettle();
    expect(find.text('Áreas disponibles'), findsOneWidget);

    await tester.tap(tab('Inicio'));
    await tester.pumpAndSettle();
    expect(find.text('Hola, Residente Demo'), findsOneWidget);
  });

  testWidgets('reserva desde Inicio → detalle (pestaña Reservas) → volver a la lista', (tester) async {
    await launchSignedIn(tester);

    await tester.tap(find.text('Piscina principal Mayor'));
    await tester.pumpAndSettle();
    expect(find.text('Detalle de la reserva'), findsOneWidget);
    final navBar = tester.widget<NavigationBar>(find.byType(NavigationBar));
    expect(navBar.selectedIndex, 2, reason: 'el detalle vive en la pestaña Reservas');

    await tester.ensureVisible(find.text('Volver a mis reservas'));
    await tester.tap(find.text('Volver a mis reservas'));
    await tester.pumpAndSettle();
    expect(find.text('Áreas disponibles'), findsOneWidget);
    expect(tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex, 2);
  });

  testWidgets('desde Inicio, "Ver mis pagos" abre Mis pagos con flecha atrás a Mis deudas', (tester) async {
    await launchSignedIn(tester);

    await tester.tap(find.text('Ver mis pagos →'));
    await tester.pumpAndSettle();
    expect(find.text('Mis pagos'), findsOneWidget);
    expect(tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex, 1);

    await tester.tap(find.byTooltip('Volver'));
    await tester.pumpAndSettle();
    expect(find.text('Mis deudas'), findsOneWidget);
  });
}
