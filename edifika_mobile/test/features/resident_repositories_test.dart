import 'package:dio/dio.dart';
import 'package:edifika_mobile/core/network/api_client.dart';
import 'package:edifika_mobile/core/network/api_exception.dart';
import 'package:edifika_mobile/features/forum/data/forum_repository_impl.dart';
import 'package:edifika_mobile/features/notifications/data/notifications_repository_impl.dart';
import 'package:edifika_mobile/features/payments/data/payments_repository_impl.dart';
import 'package:edifika_mobile/features/payments/domain/payment_models.dart';
import 'package:edifika_mobile/features/reservations/data/reservations_repository_impl.dart';
import 'package:edifika_mobile/features/reservations/domain/reservation_models.dart';
import 'package:edifika_mobile/features/residential/data/residential_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_http_adapter.dart';
import '../helpers/memory_session_storage.dart';

// Payloads copiados de server/db.json del repo web.
const _debt = {
  'id': 1,
  'unitId': 2,
  'description': 'Maintenance fee October',
  'amount': 850,
  'currency': 'PEN',
  'dueDate': '2026-06-30',
  'status': 'PENDING',
};
const _payment = {
  'id': 1,
  'debtId': 1,
  'userId': 2,
  'amount': 500,
  'currency': 'PEN',
  'paymentDate': '2026-06-10',
  'paymentMethod': 'YAPE',
  'status': 'PAID',
};
const _commonArea = {
  'id': 1,
  'name': 'Piscina principal Mayor',
  'type': 'POOL',
  'status': 'AVAILABLE',
  'maxCapacity': 11,
  'bookingType': 'SHARED',
  'rules': {
    'maxReservationHours': 2,
    'requiresPayment': false,
    'price': 0,
    'requiresGuarantee': true,
    'guaranteeAmount': 50,
    'allowCancellation': true,
    'penaltyHoursBefore': 24,
    'penaltyAmount': 20,
    'requiresApproval': false,
  },
};
Map<String, Object> _reservation({int id = 1, int slot = 9, String status = 'ACTIVE', String date = '2026-06-25'}) => {
      'id': id,
      'residentId': 2,
      'commonAreaId': 1,
      'reservationDate': date,
      'timeSlot': slot,
      'numberOfGuests': 4,
      'status': status,
      'qrCodeAccess': 'qr-1',
      'penaltyApplied': false,
    };

void main() {
  late FakeHttpAdapter adapter;
  late Dio dio;

  setUp(() {
    adapter = FakeHttpAdapter({});
    dio = createApiClient(session: MemorySessionStorage(), onUnauthorized: () {}, baseUrl: 'http://test/api/v1')
      ..httpClientAdapter = adapter;
  });

  group('ResidentialRepository', () {
    test('obtiene la unidad activa del residente vía /residential/residents/me', () async {
      adapter.routes['GET /api/v1/residential/residents/me'] = const FakeRoute(200, {
        'buildingId': 1,
        'buildingName': 'Residencial Los Olivos',
        'unitId': 2,
        'unitNumber': 102,
        'relationType': 'TENANT',
      });

      final me = await ResidentialRepositoryImpl(dio).getMyResidence();

      expect(me.buildingId, 1);
      expect(me.unitId, 2);
      expect(me.relationType, 'TENANT');
    });

    test('404 si el residente no tiene unidad asignada', () async {
      adapter.routes['GET /api/v1/residential/residents/me'] = const FakeRoute(404, {'message': 'El usuario no tiene una unidad asignada'});

      await expectLater(
        ResidentialRepositoryImpl(dio).getMyResidence(),
        throwsA(isA<ApiException>().having((e) => e.statusCode, 'statusCode', 404)),
      );
    });
  });

  group('PaymentsRepository', () {
    test('deudas por unidad y pagos por usuario', () async {
      adapter.routes['GET /api/v1/payments/debts/unit/2'] = const FakeRoute(200, [_debt]);
      adapter.routes['GET /api/v1/payments/user/2'] = const FakeRoute(200, [_payment]);
      final repository = PaymentsRepositoryImpl(dio);

      final debts = await repository.getDebtsByUnit(2);
      final payments = await repository.getPaymentsByUser(2);

      expect(debts.single.amount, 850.0);
      expect(payments.single.paymentMethod, 'YAPE');
    });

    test('Debt.isOverdue: pendiente y con fecha vencida', () {
      final debt = Debt.fromJson(_debt);

      expect(debt.isOverdue(DateTime(2026, 7, 1)), isTrue);
      expect(debt.isOverdue(DateTime(2026, 6, 1)), isFalse);
      expect(debt.copyWith(status: 'PAID').isOverdue(DateTime(2026, 7, 1)), isFalse);
    });
  });

  group('ReservationsRepository', () {
    test('áreas comunes con sus reglas anidadas', () async {
      adapter.routes['GET /api/v1/common-areas'] = const FakeRoute(200, [_commonArea]);

      final areas = await ReservationsRepositoryImpl(dio).getCommonAreas();

      expect(areas.single.isAvailable, isTrue);
      expect(areas.single.rules?.guaranteeAmount, 50.0);
    });

    test('crear reserva envía el cuerpo que espera la fake API', () async {
      adapter.routes['POST /api/v1/reservations'] = FakeRoute(201, _reservation(id: 4, slot: 10));

      final created = await ReservationsRepositoryImpl(dio)
          .createReservation(residentId: 2, commonAreaId: 1, reservationDate: '2026-06-25', timeSlot: 10, numberOfGuests: 4);

      expect(created.id, 4);
      expect(adapter.requests.single.data, {
        'residentId': 2,
        'commonAreaId': 1,
        'reservationDate': '2026-06-25',
        'timeSlot': 10,
        'numberOfGuests': 4,
      });
    });

    test('horario duplicado → ApiException conflict', () async {
      adapter.routes['POST /api/v1/reservations'] =
          const FakeRoute(409, {'message': 'Este horario ya se encuentra reservado, elija otro'});

      await expectLater(
        ReservationsRepositoryImpl(dio).createReservation(residentId: 2, commonAreaId: 1, reservationDate: '2026-06-25', timeSlot: 9),
        throwsA(isA<ApiException>().having((e) => e.kind, 'kind', ApiErrorKind.conflict)),
      );
    });

    test('cancelar usa POST /reservations/:id/cancelations', () async {
      adapter.routes['POST /api/v1/reservations/1/cancelations'] = FakeRoute(200, _reservation(status: 'CANCELLED'));

      final cancelled = await ReservationsRepositoryImpl(dio).cancelReservation(1);

      expect(cancelled.isActive, isFalse);
    });

    test('takenTimeSlots solo cuenta reservas ACTIVE de esa área y fecha', () {
      final reservations = [
        _reservation(id: 1, slot: 9),
        _reservation(id: 2, slot: 10, status: 'CANCELLED'),
        _reservation(id: 3, slot: 11, date: '2026-06-26'),
        _reservation(id: 4, slot: 15),
      ].map(Reservation.fromJson);

      expect(takenTimeSlots(reservations, commonAreaId: 1, date: '2026-06-25'), {9, 15});
    });
  });

  group('Foro y notificaciones (respuestas paginadas)', () {
    test('posts desde { content: [...] }', () async {
      adapter.routes['GET /api/v1/posts'] = const FakeRoute(200, {
        'content': [
          {'id': 1, 'title': 'Mantenimiento del ascensor', 'content': '¿Terminará hoy?', 'residentId': 2, 'createdAt': '2026-06-22T14:15:00'},
        ],
        'totalElements': 1,
      });

      final posts = await ForumRepositoryImpl(dio).getPosts();

      expect(posts.single.title, 'Mantenimiento del ascensor');
    });

    test('notificaciones del usuario y marcar como leída', () async {
      const notification = {'id': 1, 'userId': 2, 'title': 'Pago pendiente', 'content': 'Tiene una deuda pendiente.', 'read': false, 'createdAt': '2026-07-10T20:00:00'};
      adapter.routes['GET /api/v1/notifications/user/2'] = const FakeRoute(200, {
        'content': [notification],
      });
      adapter.routes['PATCH /api/v1/notifications/1/read'] = FakeRoute(200, {...notification, 'read': true});
      final repository = NotificationsRepositoryImpl(dio);

      final list = await repository.getByUser(2);
      final read = await repository.markAsRead(1);

      expect(list.single.read, isFalse);
      expect(read.read, isTrue);
    });
  });
}
