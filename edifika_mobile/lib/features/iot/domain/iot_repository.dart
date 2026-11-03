import 'iot_models.dart';

/// Estado y control IoT de un edificio. Las lecturas requieren rol ADMIN en
/// los microservicios. El emparejamiento de gateways y dispositivos se hace
/// manualmente en el backend por ahora.
abstract class IotRepository {
  /// `GET /iot/gateways?buildingId=`
  Future<List<IotGateway>> getGateways(int buildingId);

  /// `GET /iot/devices?buildingId=`
  Future<List<IotDevice>> getDevices(int buildingId);

  /// `GET /iot/devices/{id}`
  Future<IotDevice> getDevice(int deviceId);

  /// `GET /telemetry/devices?buildingId=`
  Future<List<DeviceTelemetry>> getTelemetry(int buildingId);

  /// `GET /telemetry/devices/{deviceCode}/latest`: últimas lecturas de un dispositivo.
  Future<DeviceTelemetry> getDeviceTelemetry(String deviceCode);

  /// `POST /iot/devices/{id}/reservations`. Sin `holderUserId` la reserva
  /// queda a nombre de quien la crea.
  Future<DoorReservation> createReservation(int deviceId, {required DateTime startsAt, required DateTime endsAt});

  /// `PUT /iot/devices/{id}/led`. El backend exige la puerta activa y en modo
  /// `RESERVED`; devuelve el comando en `PENDING`.
  Future<DeviceCommand> setLedColor(int deviceId, String color);

  /// `GET /iot/device-commands/{commandId}`
  Future<DeviceCommand> getCommand(String commandId);

  /// `POST /iot/devices/{id}/enrollment`: pone el lector en modo registro (60 s).
  Future<CardEnrollment> startEnrollment(int deviceId);

  /// `GET /iot/devices/{id}/enrollment`: consulta la sesión de registro (o `null` si responde 204).
  Future<CardEnrollment?> getEnrollment(int deviceId);

  /// `DELETE /iot/devices/{id}/enrollment`: sale del modo registro.
  Future<void> cancelEnrollment(int deviceId);

  /// `POST /access/credentials`: asocia la tarjeta RFID capturada a un residente del edificio.
  /// Una tarjeta revocada o perdida se reasigna al nuevo titular.
  Future<AccessCredential> createCredential({
    required String rfidUid,
    required int buildingId,
    required int userId,
    required String holderName,
  });

  /// `GET /iot/discovered-devices?buildingId=`: nodos identificados por los gateways
  /// del edificio que esperan ser adoptados.
  Future<List<DiscoveredDevice>> getDiscoveredDevices(int buildingId);

  /// `POST /iot/discovered-devices/{id}/identify`: el nodo parpadea y suena.
  Future<void> identifyDiscoveredDevice(int discoveredId, {int seconds = 10});

  /// `POST /iot/discovered-devices/{id}/adopt`: crea el dispositivo (queda `PROVISIONED`
  /// y pasa a `ACTIVE` con su primer heartbeat).
  Future<IotDevice> adoptDiscoveredDevice(
    int discoveredId, {
    required String name,
    required String location,
    required List<String> capabilities,
    required int unlockSeconds,
    String deviceType = 'DOOR',
  });

  /// `POST /iot/discovered-devices/{id}/ignore`: deja de listarse como pendiente.
  Future<void> ignoreDiscoveredDevice(int discoveredId);

  /// `GET /access/credentials?buildingId=`: tarjetas registradas en el edificio.
  Future<List<AccessCredential>> getCredentials(int buildingId);

  /// `PATCH /access/credentials/{id}/status`: `ACTIVE`, `SUSPENDED`, `REVOKED` o `LOST`.
  Future<AccessCredential> changeCredentialStatus(int credentialId, String status);
}
