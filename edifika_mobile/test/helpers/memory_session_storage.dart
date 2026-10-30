import 'package:edifika_mobile/core/storage/session_storage.dart';

class MemorySessionStorage implements SessionStorage {
  String? token;
  String? userJson;
  bool? lastPersist;

  @override
  Future<String?> readToken() async => token;

  @override
  Future<String?> readUserJson() async => userJson;

  @override
  Future<void> save({required String token, required String userJson, bool persist = true}) async {
    this.token = token;
    this.userJson = userJson;
    lastPersist = persist;
  }

  @override
  Future<void> clear() async {
    token = null;
    userJson = null;
  }
}
