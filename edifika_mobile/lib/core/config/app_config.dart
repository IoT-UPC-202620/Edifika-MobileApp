/// Configuración de entorno de la app.
///
/// Único punto de configuración de la URL base, equivalente a
/// `environment.serverBaseUrl` del frontend web. Se cambia sin tocar código:
///
/// `flutter run --dart-define=API_BASE_URL=https://api-gateway.ejemplo/api/v1`
///
/// Por defecto apunta a la fake API (json-server del repo web) corriendo en la
/// PC. Desde el emulador de Android, `10.0.2.2` es el `localhost` de la PC.
class AppConfig {
  const AppConfig._();

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000/api/v1',
  );

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
