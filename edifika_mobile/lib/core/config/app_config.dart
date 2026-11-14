/// Configuración de entorno de la app.
///
/// Único punto de configuración de la URL base, equivalente a
/// `environment.serverBaseUrl` del frontend web. Se cambia sin tocar código:
///
/// `flutter run --dart-define=API_BASE_URL=https://api-gateway.ejemplo/api/v1`
///
/// Por defecto apunta al ApiGateway local (puerto 8080). Desde el emulador de
/// Android, `10.0.2.2` es el `localhost` de la PC. Otras opciones:
/// - celular fisico en la misma WiFi: `http://<IP-de-la-PC>:8080/api/v1`
/// - tunel ngrok: `https://<dominio>.ngrok-free.app/api/v1`
/// `local/start-mobile.ps1` lo toma de `android/local.properties` (API_BASE_URL).
class AppConfig {
  const AppConfig._();

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080/api/v1',
  );

  /// Llave PUBLICA de Culqi (pk_test_... / pk_live_...) para tokenizar tarjetas en el cliente.
  /// Se inyecta como API_BASE_URL: `--dart-define=CULQI_PUBLIC_KEY=pk_test_...`
  /// (local/start-mobile.ps1 la toma de android/local.properties). Nunca la llave secreta.
  static const String culqiPublicKey = String.fromEnvironment('CULQI_PUBLIC_KEY');

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
