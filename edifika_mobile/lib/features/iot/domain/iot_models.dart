import 'package:freezed_annotation/freezed_annotation.dart';

part 'iot_models.freezed.dart';
part 'iot_models.g.dart';

/// Edge Gateway de un edificio (`GatewayResource` de IoT Access Management).
/// Los dispositivos se emparejan al edificio a través de su gateway.
@freezed
abstract class IotGateway with _$IotGateway {
  const factory IotGateway({
    required int id,
    required String gatewayCode,
    required int buildingId,
    required String name,

    /// `ONLINE`, `OFFLINE`, `PROVISIONED` o `DECOMMISSIONED`.
    required String status,
    @Default(0) int syncVersion,
    String? lastSyncAt,
    String? createdAt,
  }) = _IotGateway;

  factory IotGateway.fromJson(Map<String, dynamic> json) => _$IotGatewayFromJson(json);
}

/// Dispositivo IoT (`DeviceResource`). Hoy el único tipo es `DOOR`: el nodo
/// ESP32 de puerta (RFID, cerradura, buzzer, OLED, LED RGB y DHT11).
@freezed
abstract class IotDevice with _$IotDevice {
  const factory IotDevice({
    required int id,
    required String deviceCode,
    required int gatewayId,
    @Default('') String gatewayCode,
    required int buildingId,
    required String name,
    @Default('') String location,
    @Default('DOOR') String deviceType,
    @Default(<String>[]) List<String> capabilities,

    /// `FREE_ACCESS` o `RESERVED`.
    @Default('FREE_ACCESS') String accessMode,
    int? activeReservationId,
    String? ledColor,
    @Default(0) int unlockSeconds,
    String? firmwareVersion,

    /// `PROVISIONED`, `ACTIVE`, `MAINTENANCE`, `OFFLINE` o `DECOMMISSIONED`.
    required String status,
    String? lastSeenAt,
    String? createdAt,
  }) = _IotDevice;

  factory IotDevice.fromJson(Map<String, dynamic> json) => _$IotDeviceFromJson(json);
}

/// Reserva de una puerta (`DoorReservationResource`).
@freezed
abstract class DoorReservation with _$DoorReservation {
  const factory DoorReservation({
    required int id,
    required int deviceId,
    required int holderUserId,
    required String startsAt,
    required String endsAt,

    /// `SCHEDULED`, `ACTIVE`, `ENDED` o `CANCELLED`.
    required String status,
    @Default(<int>[]) List<int> authorizedUserIds,
    int? createdBy,
    String? createdAt,
  }) = _DoorReservation;

  factory DoorReservation.fromJson(Map<String, dynamic> json) => _$DoorReservationFromJson(json);
}

/// Comando enviado a un dispositivo (`DeviceCommandResource`). Queda en
/// `PENDING` hasta que el nodo confirma: `OK`, `FAILED` o `EXPIRED`.
@freezed
abstract class DeviceCommand with _$DeviceCommand {
  const DeviceCommand._();

  const factory DeviceCommand({
    required String commandId,
    required int deviceId,

    /// `SET_LED` o `ENROLL`.
    required String type,
    @Default(<String, dynamic>{}) Map<String, dynamic> params,
    required String status,

    /// Motivo que envía el nodo al rechazar (p. ej. `not reserved`).
    String? detail,
    String? requestedAt,
    String? expiresAt,
    String? resolvedAt,
  }) = _DeviceCommand;

  factory DeviceCommand.fromJson(Map<String, dynamic> json) => _$DeviceCommandFromJson(json);

  bool get isPending => status.toUpperCase() == 'PENDING';
}

/// Credencial que ya usa la tarjeta capturada (`CardEnrollmentResource.existingCredential`).
@freezed
abstract class ExistingCardCredential with _$ExistingCardCredential {
  const factory ExistingCardCredential({
    required int id,
    int? userId,
    String? holderName,
    String? status,
  }) = _ExistingCardCredential;

  factory ExistingCardCredential.fromJson(Map<String, dynamic> json) => _$ExistingCardCredentialFromJson(json);
}

/// Sesión de registro de tarjeta en un lector (`CardEnrollmentResource`).
@freezed
abstract class CardEnrollment with _$CardEnrollment {
  const CardEnrollment._();

  const factory CardEnrollment({
    required int id,
    required int deviceId,
    required String deviceCode,
    required int buildingId,

    /// `ACTIVE`, `CAPTURED`, `CANCELLED` o `EXPIRED`.
    required String status,
    required String startedAt,
    required String expiresAt,
    String? capturedUid,
    String? capturedAt,
    ExistingCardCredential? existingCredential,
  }) = _CardEnrollment;

  factory CardEnrollment.fromJson(Map<String, dynamic> json) => _$CardEnrollmentFromJson(json);

  bool get isActive => status.toUpperCase() == 'ACTIVE';
  bool get isCaptured => status.toUpperCase() == 'CAPTURED';
  bool get isExpired => status.toUpperCase() == 'EXPIRED';
  bool get isCancelled => status.toUpperCase() == 'CANCELLED';
}

/// Credencial RFID de acceso (`CredentialResource`).
@freezed
abstract class AccessCredential with _$AccessCredential {
  const factory AccessCredential({
    required int id,
    required String rfidUid,
    required int buildingId,
    int? userId,
    String? holderName,
    required String status,
    String? suspensionReason,
    String? validFrom,
    String? validUntil,
    String? origin,
    String? createdAt,
    String? updatedAt,
  }) = _AccessCredential;

  factory AccessCredential.fromJson(Map<String, dynamic> json) => _$AccessCredentialFromJson(json);
}

/// Última lectura de un sensor (`DeviceTelemetryResource.latest[]`).
@freezed
abstract class SensorReading with _$SensorReading {
  const factory SensorReading({
    /// `TEMPERATURE`, `HUMIDITY` o `ULTRASONIC`.
    required String magnitude,
    double? value,
    @Default('') String unit,
    String? capturedAt,
  }) = _SensorReading;

  factory SensorReading.fromJson(Map<String, dynamic> json) => _$SensorReadingFromJson(json);
}

/// Estado de conexión y últimas lecturas de un dispositivo (IoT Telemetry).
@freezed
abstract class DeviceTelemetry with _$DeviceTelemetry {
  const factory DeviceTelemetry({
    required String deviceCode,
    int? deviceId,
    @Default('') String name,
    int? buildingId,

    /// `ACTIVE` u `OFFLINE`.
    @Default('OFFLINE') String connectionStatus,
    String? lastHeartbeatAt,
    @Default(<SensorReading>[]) List<SensorReading> latest,
  }) = _DeviceTelemetry;

  factory DeviceTelemetry.fromJson(Map<String, dynamic> json) => _$DeviceTelemetryFromJson(json);
}
