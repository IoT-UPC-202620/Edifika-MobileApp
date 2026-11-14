/// Rutas de recursos relativas a [AppConfig.apiBaseUrl].
///
/// Copiadas de `src/environments/environment.ts` del frontend web para que
/// web y móvil consuman el mismo contrato (fake API hoy, API Gateway mañana).
class ApiEndpoints {
  const ApiEndpoints._();

  static const String authentication = '/authentication';
  static const String signIn = '$authentication/sign-in';
  static const String signUp = '$authentication/sign-up';

  static const String users = '/users';

  static const String buildings = '/residential/buildings';
  static const String units = '/residential/units';
  static const String userUnits = '/residential/user-units';
  /// Unidad activa del usuario del token (OWNER/TENANT); 404 si no tiene.
  static const String residentsMe = '/residential/residents/me';

  static const String reservations = '/reservations';
  static const String commonAreas = '/common-areas';
  static const String commonAreaRules = '/common-area-rules';

  static const String payments = '/payments';
  static const String debts = '/payments/debts';

  static const String posts = '/posts';

  static const String announcements = '/announcements';
  /// `POST /announcements/{id}/read` con `{userId}`.
  static String announcementRead(int announcementId) => '$announcements/$announcementId/read';

  static const String notifications = '/notifications';
  static const String deviceTokens = '/device-tokens';

  // IoT (solo microservicios; la fake API no los tiene). Contrato en
  // Edifika-IoT-Platform/contracts/schemas/rest.
  static const String iotGateways = '/iot/gateways';
  static const String iotDevices = '/iot/devices';
  static const String iotDeviceCommands = '/iot/device-commands';
  static const String iotDiscoveredDevices = '/iot/discovered-devices';
  static const String accessCredentials = '/access/credentials';
  static const String telemetryDevices = '/telemetry/devices';
}
