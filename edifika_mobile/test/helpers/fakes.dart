import 'package:edifika_mobile/features/announcements/domain/announcements_repository.dart';
import 'package:edifika_mobile/features/auth/domain/auth_repository.dart';
import 'package:edifika_mobile/features/auth/domain/authenticated_user.dart';
import 'package:edifika_mobile/features/notifications/domain/notifications_repository.dart';
import 'package:edifika_mobile/features/payments/domain/payment_models.dart';
import 'package:edifika_mobile/features/payments/domain/payments_repository.dart';
import 'package:edifika_mobile/features/reservations/domain/reservation_models.dart';
import 'package:edifika_mobile/features/reservations/domain/reservations_repository.dart';
import 'package:edifika_mobile/features/residential/domain/residential_models.dart';
import 'package:edifika_mobile/features/residential/domain/residential_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockResidentialRepository extends Mock implements ResidentialRepository {}

class MockPaymentsRepository extends Mock implements PaymentsRepository {}

class MockReservationsRepository extends Mock implements ReservationsRepository {}

class MockNotificationsRepository extends Mock implements NotificationsRepository {}

class MockAnnouncementsRepository extends Mock implements AnnouncementsRepository {}

const tenant = AuthenticatedUser(
  id: 2,
  email: 'resident@edifika.com',
  token: 'fake-jwt-token-user-2',
  fullName: 'Residente Demo',
  roles: ['TENANT'],
  buildingId: 1,
);

const building = Building(id: 1, name: 'Edificio Los Olivos');
const unit = Unit(id: 2, idBuilding: 1, unitNumber: 102, floor: 1);

Debt debt({int id = 1, double amount = 850, String due = '2026-06-30', String status = 'PENDING'}) =>
    Debt(id: id, unitId: 2, description: 'Cuota $id', amount: amount, dueDate: due, status: status);

const pool = CommonArea(
  id: 1,
  name: 'Piscina',
  type: 'POOL',
  status: 'AVAILABLE',
  maxCapacity: 10,
  rules: CommonAreaRule(maxReservationHours: 3),
);

Reservation reservation({
  required int id,
  int residentId = 2,
  int areaId = 1,
  String date = '2026-10-20',
  required int slot,
  String status = 'ACTIVE',
}) =>
    Reservation(
      id: id,
      residentId: residentId,
      commonAreaId: areaId,
      reservationDate: date,
      timeSlot: slot,
      status: status,
    );
