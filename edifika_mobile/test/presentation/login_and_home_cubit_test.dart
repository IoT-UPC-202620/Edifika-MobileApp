import 'package:edifika_mobile/core/events/data_changes.dart';
import 'package:edifika_mobile/core/network/api_exception.dart';
import 'package:edifika_mobile/core/utils/load_status.dart';
import 'package:edifika_mobile/features/auth/presentation/login_cubit.dart';
import 'package:edifika_mobile/features/home/presentation/home_cubit.dart';
import 'package:edifika_mobile/features/notifications/domain/app_notification.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fakes.dart';

void main() {
  group('LoginCubit', () {
    late MockAuthRepository auth;

    setUp(() => auth = MockAuthRepository());

    test('pide correo y contraseña sin llamar a la API', () async {
      final cubit = LoginCubit(auth);
      await cubit.submit(email: ' ', password: '');

      expect(cubit.state.error, isNotNull);
      verifyNever(() => auth.signIn(email: any(named: 'email'), password: any(named: 'password'), remember: any(named: 'remember')));
    });

    test('un residente inicia sesión respetando "Recordar sesión"', () async {
      when(() => auth.signIn(email: 'resident@edifika.com', password: 'x', remember: false)).thenAnswer((_) async => tenant);
      final cubit = LoginCubit(auth)..toggleRemember(false);

      await cubit.submit(email: 'resident@edifika.com', password: 'x');

      expect(cubit.state.user, tenant);
      expect(cubit.state.error, isNull);
    });

    test('un administrador inicia sesión (va a la gestión IoT)', () async {
      when(() => auth.signIn(email: any(named: 'email'), password: any(named: 'password'), remember: any(named: 'remember')))
          .thenAnswer((_) async => admin);
      final cubit = LoginCubit(auth);

      await cubit.submit(email: 'admin@edifika.com', password: 'x');

      expect(cubit.state.user, admin);
      expect(cubit.state.error, isNull);
      verifyNever(() => auth.signOut());
    });

    test('un usuario sin rol habilitado es rechazado y su sesión se cierra', () async {
      when(() => auth.signIn(email: any(named: 'email'), password: any(named: 'password'), remember: any(named: 'remember')))
          .thenAnswer((_) async => tenant.copyWith(roles: []));
      when(() => auth.signOut()).thenAnswer((_) async {});
      final cubit = LoginCubit(auth);

      await cubit.submit(email: 'nadie@edifika.com', password: 'x');

      expect(cubit.state.user, isNull);
      expect(cubit.state.error, contains('rol habilitado'));
      verify(() => auth.signOut()).called(1);
    });

    test('muestra el mensaje del servidor ante credenciales inválidas', () async {
      when(() => auth.signIn(email: any(named: 'email'), password: any(named: 'password'), remember: any(named: 'remember')))
          .thenThrow(const ApiException(ApiErrorKind.unauthorized, 'Credenciales incorrectas', statusCode: 401));
      final cubit = LoginCubit(auth);

      await cubit.submit(email: 'resident@edifika.com', password: 'mal');

      expect(cubit.state.error, 'Credenciales incorrectas');
      expect(cubit.state.submitting, isFalse);
    });
  });

  group('HomeCubit', () {
    late MockPaymentsRepository payments;
    late MockReservationsRepository reservations;
    late MockNotificationsRepository notifications;
    late MockAnnouncementsRepository announcements;

    HomeCubit build() => HomeCubit(
          payments: payments,
          reservations: reservations,
          notifications: notifications,
          announcements: announcements,
          now: () => DateTime(2026, 10, 15, 12),
        );

    setUp(() {
      payments = MockPaymentsRepository();
      reservations = MockReservationsRepository();
      notifications = MockNotificationsRepository();
      announcements = MockAnnouncementsRepository();
      when(() => reservations.getCommonAreas()).thenAnswer((_) async => [pool]);
      when(() => notifications.getByUser(2)).thenAnswer((_) async => [
            const AppNotification(id: 1, userId: 2, title: 'A', content: 'a'),
            const AppNotification(id: 2, userId: 2, title: 'B', content: 'b', read: true),
          ]);
    });

    test('resume deuda pendiente/vencida, próxima reserva y no leídas; anuncios pendientes si 404', () async {
      when(() => payments.getDebtsByUnit(2)).thenAnswer((_) async => [
            debt(id: 1, amount: 180, due: '2026-10-30'),
            debt(id: 2, amount: 60, due: '2026-09-30'),
            debt(id: 3, amount: 999, status: 'PAID'),
          ]);
      when(() => reservations.getReservations()).thenAnswer((_) async => [
            reservation(id: 1, slot: 9, date: '2026-10-01'), // pasada
            reservation(id: 2, slot: 16, date: '2026-10-20'),
            reservation(id: 3, slot: 17, date: '2026-10-20'),
            reservation(id: 4, slot: 10, date: '2026-10-18', residentId: 3), // de otro vecino
          ]);
      when(() => announcements.getByBuilding(1))
          .thenThrow(const ApiException(ApiErrorKind.notFound, 'No se encontró', statusCode: 404));

      final cubit = build();
      await cubit.load(userId: 2, buildingId: 1, unitId: 2);

      final s = cubit.state;
      expect(s.status, LoadStatus.ready);
      expect(s.pendingTotal, 180);
      expect(s.overdueTotal, 60);
      expect(s.debtTotal, 240);
      expect(s.nextReservation?.fromHour, 16);
      expect(s.nextReservation?.toHour, 18);
      expect(s.nextReservationArea, 'Piscina');
      expect(s.unreadNotifications, 1);
      expect(s.announcementsUnavailable, isTrue);
    });

    test('se recarga en silencio cuando otra pantalla modifica datos', () async {
      final changes = DataChanges();
      var reservationCalls = 0;
      when(() => payments.getDebtsByUnit(2)).thenAnswer((_) async => []);
      when(() => announcements.getByBuilding(1)).thenAnswer((_) async => []);
      when(() => reservations.getReservations()).thenAnswer((_) async {
        reservationCalls++;
        return reservationCalls == 1 ? [] : [reservation(id: 7, slot: 10, date: '2026-10-31')];
      });
      final cubit = HomeCubit(
        payments: payments,
        reservations: reservations,
        notifications: notifications,
        announcements: announcements,
        dataChanges: changes.stream,
        now: () => DateTime(2026, 10, 15, 12),
      );
      await cubit.load(userId: 2, buildingId: 1, unitId: 2);
      expect(cubit.state.nextReservation, isNull);

      final states = <HomeState>[];
      final sub = cubit.stream.listen(states.add);
      changes
        ..notify()
        ..notify(); // ráfaga: una sola recarga
      await Future<void>.delayed(const Duration(milliseconds: 400));

      expect(reservationCalls, 2);
      expect(cubit.state.nextReservation?.fromHour, 10);
      expect(states.any((s) => s.status == LoadStatus.loading), isFalse, reason: 'sin spinner en recarga silenciosa');
      await sub.cancel();
      await cubit.close();
    });

    test('pasa a failure con el mensaje si falla una llamada principal', () async {
      when(() => payments.getDebtsByUnit(2))
          .thenThrow(const ApiException(ApiErrorKind.network, 'No se pudo conectar con el servidor.'));
      when(() => reservations.getReservations()).thenAnswer((_) async => []);

      final cubit = build();
      await cubit.load(userId: 2, buildingId: 1, unitId: 2);

      expect(cubit.state.status, LoadStatus.failure);
      expect(cubit.state.error, 'No se pudo conectar con el servidor.');
    });
  });
}
