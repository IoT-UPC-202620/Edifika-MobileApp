import 'dart:async';

import 'package:edifika_mobile/features/residential/domain/my_residence.dart';
import 'package:edifika_mobile/core/theme/app_theme.dart';
import 'package:edifika_mobile/features/auth/presentation/session_cubit.dart';
import 'package:edifika_mobile/features/payments/domain/payments_repository.dart';
import 'package:edifika_mobile/features/payments/presentation/debts_screen.dart';
import 'package:edifika_mobile/features/residential/domain/residential_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fakes.dart';

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  Future<void> pumpDebts(WidgetTester tester, MockPaymentsRepository payments) async {
    final residential = MockResidentialRepository();
    when(() => residential.getBuilding(1)).thenAnswer((_) async => building);
    when(() => residential.getMyResidence()).thenAnswer((_) async => const MyResidence(
          buildingId: 1,
          buildingName: 'Edificio Los Olivos',
          unitId: 2,
          unitNumber: 102,
          relationType: 'OWNER',
        ));
    when(() => residential.getUnit(2)).thenAnswer((_) async => unit);

    final session = SessionCubit(
      auth: MockAuthRepository(),
      residential: residential,
      sessionExpired: const Stream.empty(),
    );
    await session.signedIn(tenant);

    await tester.pumpWidget(
      RepositoryProvider<PaymentsRepository>.value(
        value: payments,
        child: BlocProvider.value(
          value: session,
          child: MaterialApp(theme: AppTheme.light(), home: const DebtsScreen()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('muestra total, chips Pendiente/Vencida en texto y ubicación', (tester) async {
    final payments = MockPaymentsRepository();
    final future = DateTime.now().add(const Duration(days: 30)).toIso8601String().substring(0, 10);
    when(() => payments.getDebtsByUnit(2)).thenAnswer((_) async => [
          debt(id: 1, amount: 180, due: future),
          debt(id: 2, amount: 60, due: '2020-01-31'),
        ]);

    await pumpDebts(tester, payments);

    expect(find.text('Mis deudas'), findsOneWidget);
    expect(find.text('Edificio Los Olivos · Departamento 102'), findsOneWidget);
    expect(find.text('S/ 240.00'), findsOneWidget);
    expect(find.text('Pendiente'), findsOneWidget);
    expect(find.text('Vencida'), findsOneWidget);
    expect(find.text('La fecha de vencimiento ya pasó.'), findsOneWidget);
  });

  testWidgets('estado vacío cuando no hay deudas pendientes', (tester) async {
    final payments = MockPaymentsRepository();
    when(() => payments.getDebtsByUnit(2)).thenAnswer((_) async => [debt(status: 'PAID')]);

    await pumpDebts(tester, payments);

    expect(find.text('No tienes deudas pendientes.'), findsOneWidget);
    expect(find.text('S/ 0.00'), findsOneWidget);
  });
}
