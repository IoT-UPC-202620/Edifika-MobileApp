import 'dart:convert';

import 'package:edifika_mobile/core/network/api_client.dart';
import 'package:edifika_mobile/features/auth/data/auth_repository_impl.dart';
import 'package:edifika_mobile/features/auth/data/jwt_expiry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_http_adapter.dart';
import '../helpers/memory_session_storage.dart';

/// Respuesta real de `POST /authentication/sign-in` en la fake API (server/app.js).
const _signInResponse = {
  'id': 2,
  'email': 'resident@edifika.com',
  'fullName': 'Residente Demo',
  'roles': ['TENANT'],
  'buildingId': 1,
  'token': 'fake-jwt-token-user-2',
};

String _jwtWithExp(DateTime exp) {
  String part(Map<String, Object> json) => base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');
  return '${part({'alg': 'none'})}.${part({'exp': exp.millisecondsSinceEpoch ~/ 1000})}.sig';
}

void main() {
  late MemorySessionStorage session;
  late FakeHttpAdapter adapter;
  late AuthRepositoryImpl repository;

  setUp(() {
    session = MemorySessionStorage();
    adapter = FakeHttpAdapter({'POST /api/v1/authentication/sign-in': const FakeRoute(200, _signInResponse)});
    final dio = createApiClient(session: session, onUnauthorized: () {}, baseUrl: 'http://test/api/v1')
      ..httpClientAdapter = adapter;
    repository = AuthRepositoryImpl(dio, session);
  });

  test('signIn parsea la respuesta y guarda la sesión', () async {
    final user = await repository.signIn(email: 'resident@edifika.com', password: 'x');

    expect(user.id, 2);
    expect(user.buildingId, 1);
    expect(user.isResident, isTrue);
    expect(session.token, 'fake-jwt-token-user-2');
    expect(adapter.requests.single.data, {'email': 'resident@edifika.com', 'password': 'x'});
  });

  test('restoreSession devuelve el usuario guardado', () async {
    await repository.signIn(email: 'resident@edifika.com', password: 'x');

    final restored = await repository.restoreSession();

    expect(restored?.email, 'resident@edifika.com');
  });

  test('restoreSession limpia una sesión con JWT expirado', () async {
    session
      ..token = _jwtWithExp(DateTime.now().subtract(const Duration(minutes: 1)))
      ..userJson = jsonEncode(_signInResponse);

    expect(await repository.restoreSession(), isNull);
    expect(session.token, isNull);
  });

  test('un administrador no es residente', () async {
    adapter.routes['POST /api/v1/authentication/sign-in'] = FakeRoute(200, {
      ..._signInResponse,
      'roles': ['ADMIN'],
    });

    final user = await repository.signIn(email: 'admin@edifika.com', password: 'x');

    expect(user.isResident, isFalse);
  });

  group('isJwtExpired (misma regla que el web)', () {
    test('los tokens fake (no JWT) no expiran', () => expect(isJwtExpired('fake-jwt-token-user-2'), isFalse));

    test('JWT vigente', () => expect(isJwtExpired(_jwtWithExp(DateTime.now().add(const Duration(hours: 1)))), isFalse));

    test('JWT vencido', () => expect(isJwtExpired(_jwtWithExp(DateTime.now().subtract(const Duration(hours: 1)))), isTrue));

    test('JWT ilegible se considera vencido', () => expect(isJwtExpired('a.!!!.c'), isTrue));
  });
}
