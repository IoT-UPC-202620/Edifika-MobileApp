import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persistencia de la sesión. Equivale a `edifika_token` / `edifika_user`
/// del `localStorage` del frontend web, pero cifrado en el dispositivo.
abstract class SessionStorage {
  Future<String?> readToken();
  Future<String?> readUserJson();

  /// Con `persist: false` ("Recordar sesión" desmarcado) la sesión vive solo
  /// en memoria y se pierde al cerrar la app.
  Future<void> save({required String token, required String userJson, bool persist = true});
  Future<void> clear();
}

class SecureSessionStorage implements SessionStorage {
  SecureSessionStorage([FlutterSecureStorage? storage]) : _storage = storage ?? const FlutterSecureStorage();

  static const _tokenKey = 'edifika_token';
  static const _userKey = 'edifika_user';

  final FlutterSecureStorage _storage;
  String? _token;
  String? _userJson;

  @override
  Future<String?> readToken() async => _token ??= await _storage.read(key: _tokenKey);

  @override
  Future<String?> readUserJson() async => _userJson ??= await _storage.read(key: _userKey);

  @override
  Future<void> save({required String token, required String userJson, bool persist = true}) async {
    _token = token;
    _userJson = userJson;
    if (persist) {
      await _storage.write(key: _tokenKey, value: token);
      await _storage.write(key: _userKey, value: userJson);
    } else {
      await _deletePersisted();
    }
  }

  @override
  Future<void> clear() async {
    _token = null;
    _userJson = null;
    await _deletePersisted();
  }

  Future<void> _deletePersisted() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }
}
