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

  static const String reservations = '/reservations';
  static const String commonAreas = '/common-areas';
  static const String commonAreaRules = '/common-area-rules';

  static const String payments = '/payments';
  static const String debts = '/payments/debts';

  static const String posts = '/posts';

  static const String announcements = '/announcements';
  static const String announcementReads = '/announcement-reads';

  static const String notifications = '/notifications';
  static const String deviceTokens = '/device-tokens';
}
