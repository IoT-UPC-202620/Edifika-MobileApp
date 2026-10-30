import 'package:dio/dio.dart';
import 'package:edifika_mobile/core/network/api_client.dart';
import 'package:edifika_mobile/core/network/api_exception.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_http_adapter.dart';
import '../helpers/memory_session_storage.dart';

void main() {
  const base = 'http://test/api/v1';

  Dio buildDio(MemorySessionStorage session, FakeHttpAdapter adapter, {void Function()? onUnauthorized}) {
    return createApiClient(session: session, onUnauthorized: onUnauthorized ?? () {}, baseUrl: base)
      ..httpClientAdapter = adapter;
  }

  group('AuthInterceptor', () {
    test('agrega el Bearer token cuando hay sesión', () async {
      final session = MemorySessionStorage()..token = 'abc';
      final adapter = FakeHttpAdapter({'GET /api/v1/users/2': const FakeRoute(200, {'id': 2})});

      await buildDio(session, adapter).get<Object>('/users/2');

      expect(adapter.requests.single.headers['Authorization'], 'Bearer abc');
    });

    test('no agrega Authorization sin sesión', () async {
      final adapter = FakeHttpAdapter({'GET /api/v1/posts': const FakeRoute(200, [])});

      await buildDio(MemorySessionStorage(), adapter).get<Object>('/posts');

      expect(adapter.requests.single.headers.containsKey('Authorization'), isFalse);
    });

    test('un 401 con token limpia la sesión y avisa', () async {
      final session = MemorySessionStorage()
        ..token = 'abc'
        ..userJson = '{}';
      var notified = false;
      final adapter = FakeHttpAdapter({'GET /api/v1/users/2': const FakeRoute(401, {'message': 'expired'})});

      await expectLater(
        guardApiCall(() => buildDio(session, adapter, onUnauthorized: () => notified = true).get<Object>('/users/2')),
        throwsA(isA<ApiException>().having((e) => e.kind, 'kind', ApiErrorKind.unauthorized)),
      );
      expect(session.token, isNull);
      expect(notified, isTrue);
    });

    test('un 401 sin token (login fallido) no dispara cierre de sesión', () async {
      var notified = false;
      final adapter = FakeHttpAdapter({
        'POST /api/v1/authentication/sign-in': const FakeRoute(401, {'message': 'Credenciales incorrectas'}),
      });

      await expectLater(
        guardApiCall(
          () => buildDio(MemorySessionStorage(), adapter, onUnauthorized: () => notified = true)
              .post<Object>('/authentication/sign-in'),
        ),
        throwsA(isA<ApiException>().having((e) => e.message, 'message', 'Credenciales incorrectas')),
      );
      expect(notified, isFalse);
    });
  });

  group('ApiException.fromDio', () {
    test('mapea 409 a conflicto con el mensaje del servidor', () async {
      final adapter = FakeHttpAdapter({
        'POST /api/v1/reservations': const FakeRoute(409, {'message': 'Este horario ya se encuentra reservado, elija otro'}),
      });

      await expectLater(
        guardApiCall(() => buildDio(MemorySessionStorage(), adapter).post<Object>('/reservations')),
        throwsA(
          isA<ApiException>()
              .having((e) => e.kind, 'kind', ApiErrorKind.conflict)
              .having((e) => e.message, 'message', 'Este horario ya se encuentra reservado, elija otro'),
        ),
      );
    });

    test('usa un mensaje por defecto si el servidor no envía message', () {
      final error = DioException(
        requestOptions: RequestOptions(path: '/x'),
        type: DioExceptionType.badResponse,
        response: Response<Object>(requestOptions: RequestOptions(path: '/x'), statusCode: 500),
      );

      final apiError = ApiException.fromDio(error);

      expect(apiError.kind, ApiErrorKind.server);
      expect(apiError.message, isNotEmpty);
    });

    test('mapea error de conexión a network', () {
      final error = DioException(requestOptions: RequestOptions(path: '/x'), type: DioExceptionType.connectionError);

      expect(ApiException.fromDio(error).kind, ApiErrorKind.network);
    });
  });

  group('parseList', () {
    test('acepta una lista simple', () {
      expect(parseList([{'v': 1}, {'v': 2}], (j) => j['v']), [1, 2]);
    });

    test('acepta un Page de Spring { content: [...] }', () {
      expect(parseList({'content': [{'v': 3}], 'totalElements': 1}, (j) => j['v']), [3]);
    });

    test('devuelve lista vacía ante una forma inesperada', () {
      expect(parseList('oops', (j) => j), isEmpty);
    });
  });
}
