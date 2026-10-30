import 'dart:async';

import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../storage/session_storage.dart';
import 'api_exception.dart';

/// Crea el cliente HTTP compartido por todos los repositorios.
///
/// Equivale a `provideHttpClient(withInterceptors([authTokenInterceptor]))`
/// del frontend web: agrega el Bearer token y, ante un 401, cierra la sesión.
Dio createApiClient({
  required SessionStorage session,
  required void Function() onUnauthorized,
  String baseUrl = AppConfig.apiBaseUrl,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: AppConfig.connectTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );
  dio.interceptors.add(AuthInterceptor(session: session, onUnauthorized: onUnauthorized));
  return dio;
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.session, required this.onUnauthorized});

  final SessionStorage session;
  final void Function() onUnauthorized;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await session.readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final hadToken = err.requestOptions.headers.containsKey('Authorization');
    if (err.response?.statusCode == 401 && hadToken) {
      await session.clear();
      onUnauthorized();
    }
    handler.next(err);
  }
}

/// Ejecuta una llamada y traduce cualquier [DioException] a [ApiException].
Future<T> guardApiCall<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (error) {
    throw ApiException.fromDio(error);
  }
}

/// Algunas rutas devuelven una lista y otras un `Page<T>` de Spring
/// (`{ "content": [...] }`). Esto acepta ambas formas.
List<T> parseList<T>(Object? data, T Function(Map<String, dynamic> json) fromJson) {
  final raw = data is Map<String, dynamic> ? data['content'] : data;
  if (raw is! List) return <T>[];
  return raw.whereType<Map<String, dynamic>>().map(fromJson).toList();
}
