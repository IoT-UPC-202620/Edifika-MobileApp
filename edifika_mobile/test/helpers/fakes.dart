import 'package:edifika_mobile/features/announcements/domain/announcements_repository.dart';
import 'package:edifika_mobile/features/auth/domain/auth_repository.dart';
import 'package:edifika_mobile/features/auth/domain/authenticated_user.dart';
import 'package:edifika_mobile/features/iot/domain/iot_models.dart';
import 'package:edifika_mobile/features/iot/domain/iot_repository.dart';
import 'package:edifika_mobile/features/notifications/domain/notifications_repository.dart';
import 'package:edifika_mobile/features/payments/domain/payment_models.dart';
import 'package:edifika_mobile/features/payments/domain/payments_repository.dart';
import 'package:edifika_mobile/features/profile/domain/profile_repository.dart';
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

class MockProfileRepository extends Mock implements ProfileRepository {}

class MockIotRepository extends Mock implements IotRepository {}

const admin = AuthenticatedUser(
  id: 1,
  email: 'admin@edifika.com',
  token: 'fake-jwt-token-user-1',
  fullName: 'Ricardo Mendoza',
  roles: ['ADMIN'],
);

/// Payloads copiados de Edifika-IoT-Platform/contracts/examples/rest.
const gatewayJson = {
  'id': 1,
  'gatewayCode': 'edge-gateway-01',
  'buildingId': 12,
  'name': 'Torre A',
  'status': 'ONLINE',
  'syncVersion': 42,
  'lastSyncAt': '2026-10-23T15:00:00Z',
  'createdAt': '2026-10-23T14:00:00Z',
};

const deviceJson = {
  'id': 3,
  'deviceCode': 'esp32-acc-01',
  'gatewayId': 1,
  'gatewayCode': 'edge-gateway-01',
  'buildingId': 12,
  'name': 'Puerta piscina',
  'location': 'Piso 1',
  'deviceType': 'DOOR',
  'capabilities': ['RFID', 'LOCK', 'BUZZER', 'OLED', 'RGB_LED', 'TEMPERATURE', 'HUMIDITY'],
  'accessMode': 'RESERVED',
  'activeReservationId': 7,
  'ledColor': '#00FF88',
  'unlockSeconds': 5,
  'firmwareVersion': 'door-1.2.0',
  'status': 'ACTIVE',
  'lastSeenAt': '2026-10-23T15:00:00Z',
  'createdAt': '2026-10-23T14:00:00Z',
};

const telemetryJson = {
  'deviceCode': 'esp32-acc-01',
  'deviceId': 3,
  'name': 'Puerta piscina',
  'buildingId': 12,
  'connectionStatus': 'ACTIVE',
  'lastHeartbeatAt': '2026-10-23T15:00:00Z',
  'latest': [
    {'magnitude': 'TEMPERATURE', 'value': 24.5, 'unit': '°C', 'capturedAt': '2026-10-23T15:04:00Z'},
    {'magnitude': 'HUMIDITY', 'value': 61.0, 'unit': '%', 'capturedAt': '2026-10-23T15:04:00Z'},
  ],
};

final iotGateway = IotGateway.fromJson(gatewayJson);
final iotDevice = IotDevice.fromJson(deviceJson);
final iotTelemetry = DeviceTelemetry.fromJson(telemetryJson);

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
