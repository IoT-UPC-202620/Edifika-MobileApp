import 'package:dio/dio.dart';

enum ApiErrorKind { network, timeout, unauthorized, notFound, conflict, badRequest, server, unknown }

/// Error de API normalizado para las capas superiores (los cubits nunca ven
/// un [DioException]).
class ApiException implements Exception {
  const ApiException(this.kind, this.message, {this.statusCode});

  final ApiErrorKind kind;
  final String message;
  final int? statusCode;

  factory ApiException.fromDio(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(ApiErrorKind.timeout, 'El servidor tardó demasiado en responder.');
      case DioExceptionType.connectionError:
        return const ApiException(ApiErrorKind.network, 'No se pudo conectar con el servidor.');
      case DioExceptionType.badResponse:
        final status = error.response?.statusCode ?? 0;
        final message = _serverMessage(error.response?.data) ?? _defaultMessage(status);
        return ApiException(_kindFor(status), message, statusCode: status);
      default:
        return const ApiException(ApiErrorKind.unknown, 'Ocurrió un error inesperado.');
    }
  }

  /// La fake API (y los microservicios Spring) responden `{ "message": "..." }`.
  static String? _serverMessage(Object? data) {
    if (data is Map && data['message'] is String) return data['message'] as String;
    return null;
  }

  static ApiErrorKind _kindFor(int status) => switch (status) {
        400 => ApiErrorKind.badRequest,
        401 || 403 => ApiErrorKind.unauthorized,
        404 => ApiErrorKind.notFound,
        409 => ApiErrorKind.conflict,
        >= 500 => ApiErrorKind.server,
        _ => ApiErrorKind.unknown,
      };

  static String _defaultMessage(int status) => switch (status) {
        401 || 403 => 'Tu sesión expiró. Inicia sesión nuevamente.',
        404 => 'No se encontró el recurso solicitado.',
        >= 500 => 'El servidor tuvo un problema. Inténtalo más tarde.',
        _ => 'No se pudo completar la solicitud.',
      };

  @override
  String toString() => 'ApiException($kind, $statusCode): $message';
}
