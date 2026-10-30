import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Respuesta enlatada para una ruta `MÉTODO /ruta`.
class FakeRoute {
  const FakeRoute(this.status, this.body);
  final int status;
  final Object? body;
}

/// Adaptador HTTP en memoria: permite probar repositorios con respuestas
/// copiadas de la fake API sin levantar un servidor.
class FakeHttpAdapter implements HttpClientAdapter {
  FakeHttpAdapter(this.routes);

  final Map<String, FakeRoute> routes;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    requests.add(options);
    final route = routes['${options.method} ${options.uri.path}'] ?? const FakeRoute(404, {'message': 'Not found'});
    return ResponseBody.fromString(
      jsonEncode(route.body),
      route.status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
