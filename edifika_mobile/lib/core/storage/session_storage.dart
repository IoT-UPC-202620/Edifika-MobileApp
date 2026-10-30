import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persistencia de la sesión. Equivale a `edifika_token` / `edifika_user`
/// del `localStorage` del frontend web, pero cifrado en el dispositivo.
abstract class SessionStorage {
  Future<String?> readToken();
  Future<String?> readUserJson();
  Future<void> save({required String token, required String userJson});
  Future<void> clear();
}

class SecureSessionStorage implements SessionStorage {
  SecureSessionStorage([FlutterSecureStorage? storage]) : _storage = storage ?? const FlutterSecureStorage();

  static const _tokenKey = 'edifika_token';
  static const _userKey = 'edifika_user';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readToken() => _storage.read(key: _tokenKey);

  @override
  Future<String?> readUserJson() => _storage.read(key: _userKey);

  @override
  Future<void> save({required String token, required String userJson}) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _userKey, value: userJson);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }
}
