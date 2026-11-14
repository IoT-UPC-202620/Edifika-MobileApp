import 'package:dio/dio.dart';

import '../../../core/config/app_config.dart';

/// Error al tokenizar. El mensaje es apto para el usuario y NUNCA incluye datos de la tarjeta.
class CulqiTokenException implements Exception {
  const CulqiTokenException(this.message, {this.network = false});

  final String message;

  /// true si no hubo respuesta de Culqi (sin conexion o timeout): se puede reintentar.
  final bool network;

  @override
  String toString() => 'CulqiTokenException(network: $network)';
}

/// Tokeniza la tarjeta DIRECTAMENTE contra Culqi con la llave publica (lo mismo que hacen los SDK
/// oficiales de Android/iOS). Los datos de la tarjeta nunca pasan por nuestro backend: solo el token.
///
/// Usa su propio cliente HTTP: sin el interceptor de sesion (no envia nuestro JWT a Culqi), sin
/// interceptores de log y sin la URL base del ApiGateway.
class CulqiTokenizer {
  CulqiTokenizer({String? publicKey, Dio? dio})
      : _publicKey = publicKey ?? AppConfig.culqiPublicKey,
        _dio = dio ??
            Dio(BaseOptions(
              baseUrl: 'https://secure.culqi.com/v2',
              connectTimeout: AppConfig.connectTimeout,
              receiveTimeout: AppConfig.receiveTimeout,
              contentType: Headers.jsonContentType,
            ));

  final String _publicKey;
  final Dio _dio;

  bool get isConfigured => _publicKey.startsWith('pk_');

  /// Devuelve el id del token (`tkn_...`).
  Future<String> createToken({
    required String cardNumber,
    required String cvv,
    required int expirationMonth,
    required int expirationYear,
    required String email,
  }) async {
    if (!isConfigured) {
      throw const CulqiTokenException('Los pagos con tarjeta no están configurados en esta app.');
    }
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/tokens',
        options: Options(headers: {'Authorization': 'Bearer $_publicKey'}),
        data: {
          'card_number': cardNumber,
          'cvv': cvv,
          'expiration_month': expirationMonth.toString().padLeft(2, '0'),
          'expiration_year': expirationYear.toString(),
          'email': email,
        },
      );
      final id = response.data?['id'];
      if (id is String && id.startsWith('tkn_')) return id;
      throw const CulqiTokenException('No se pudo validar la tarjeta. Inténtalo de nuevo.');
    } on DioException catch (error) {
      // No se relanza el DioException: su requestOptions.data contiene la tarjeta.
      final data = error.response?.data;
      if (error.response == null) {
        throw const CulqiTokenException('No hay conexión con el procesador de pagos. Revisa tu internet e inténtalo de nuevo.',
            network: true);
      }
      final userMessage = data is Map ? data['user_message'] : null;
      throw CulqiTokenException(
        userMessage is String && userMessage.isNotEmpty ? userMessage : 'Revisa los datos de la tarjeta.',
      );
    }
  }
}
