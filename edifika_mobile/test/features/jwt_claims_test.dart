import 'dart:convert';

import 'package:edifika_mobile/core/network/api_client.dart';
import 'package:edifika_mobile/features/auth/data/auth_repository_impl.dart';
import 'package:edifika_mobile/features/auth/data/jwt_claims.dart';
import 'package:edifika_mobile/features/auth/domain/authenticated_user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_http_adapter.dart';
import '../helpers/memory_session_storage.dart';

/// JWT como el que firma el IAM (`sub`, `user_id`, `roles`); la firma no se valida en la app.
String _jwt(Map<String, Object> claims) {
  String part(Map<String, Object> json) => base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');
  return '${part({'alg': 'HS256'})}.${part(claims)}.firma';
}

void main() {
  group('jwtRoles', () {
    test('lee el claim roles y quita el prefijo ROLE_', () {
      expect(jwtRoles(_jwt({'roles': ['ROLE_ADMIN', 'owner']})), ['ADMIN', 'OWNER']);
    });

    test('acepta authorities de Spring ({authority: ...})', () {
      expect(
        jwtRoles(_jwt({
          'authorities': [
            {'authority': 'ROLE_TENANT'},
          ],
        })),
        ['TENANT'],
      );
    });

    test('un token fake (no JWT) o sin roles no tiene roles', () {
      expect(jwtRoles('fake-jwt-token-user-1'), isEmpty);
      expect(jwtRoles(_jwt({'sub': 'a@b.com'})), isEmpty);
    });
  });

  group('roles del usuario', () {
    const base = AuthenticatedUser(id: 1, email: 'a@b.com', token: 't');

    test('ADMIN (con o sin ROLE_) entra a la gestión IoT', () {
      expect(base.copyWith(roles: ['ROLE_ADMIN']).isAdmin, isTrue);
      expect(base.copyWith(roles: ['ADMIN']).canUseMobileApp, isTrue);
    });

    test('OWNER y TENANT son residentes; sin roles no puede ingresar', () {
      expect(base.copyWith(roles: ['owner']).isResident, isTrue);
      expect(base.copyWith(roles: ['TENANT']).isAdmin, isFalse);
      expect(base.canUseMobileApp, isFalse);
    });
  });

  test('signIn contra el IAM real (solo id, email y token) toma los roles del JWT', () async {
    final token = _jwt({'sub': 'admin@edifika.com', 'user_id': 1, 'roles': ['ROLE_ADMIN']});
    final adapter = FakeHttpAdapter({
      'POST /api/v1/authentication/sign-in': FakeRoute(200, {'id': 1, 'email': 'admin@edifika.com', 'token': token}),
    });
    final session = MemorySessionStorage();
    final dio = createApiClient(session: session, onUnauthorized: () {}, baseUrl: 'http://test/api/v1')
      ..httpClientAdapter = adapter;

    final user = await AuthRepositoryImpl(dio, session).signIn(email: 'admin@edifika.com', password: 'x');

    expect(user.roles, ['ADMIN']);
    expect(user.isAdmin, isTrue);
    expect(jsonDecode(session.userJson!)['roles'], ['ADMIN'], reason: 'los roles se guardan para restaurar la sesión');
  });
}
