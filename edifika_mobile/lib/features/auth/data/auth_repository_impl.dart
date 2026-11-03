import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/session_storage.dart';
import '../domain/auth_repository.dart';
import '../domain/authenticated_user.dart';
import 'jwt_claims.dart';
import 'jwt_expiry.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dio, this._session);

  final Dio _dio;
  final SessionStorage _session;

  @override
  Future<AuthenticatedUser> signIn({required String email, required String password, bool remember = true}) async {
    final user = await guardApiCall(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.signIn,
        data: {'email': email, 'password': password},
      );
      final parsed = AuthenticatedUser.fromJson(response.data!);
      // El IAM real no envía `roles` en el cuerpo: se toman del JWT.
      return parsed.roles.isNotEmpty ? parsed : parsed.copyWith(roles: jwtRoles(parsed.token));
    });
    await _session.save(token: user.token, userJson: jsonEncode(user.toJson()), persist: remember);
    return user;
  }

  @override
  Future<AuthenticatedUser?> restoreSession() async {
    final token = await _session.readToken();
    final userJson = await _session.readUserJson();
    if (token == null || userJson == null || isJwtExpired(token)) {
      await _session.clear();
      return null;
    }
    try {
      return AuthenticatedUser.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
    } on FormatException {
      await _session.clear();
      return null;
    }
  }

  @override
  Future<void> signOut() => _session.clear();
}
