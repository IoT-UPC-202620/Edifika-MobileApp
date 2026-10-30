import 'dart:convert';

/// Misma regla que `LoginService.isTokenExpired` del frontend web:
/// - Un token que no es JWT (los `fake-jwt-token-...` de la fake API) no expira.
/// - Un JWT sin `exp` no expira.
/// - Un JWT ilegible se considera expirado.
bool isJwtExpired(String token, {DateTime? now}) {
  final parts = token.split('.');
  if (parts.length != 3) return false;

  try {
    final payload = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
    final exp = payload is Map<String, dynamic> ? payload['exp'] : null;
    if (exp is! num) return false;
    final expiresAt = DateTime.fromMillisecondsSinceEpoch((exp * 1000).toInt());
    return !(now ?? DateTime.now()).isBefore(expiresAt);
  } catch (_) {
    return true;
  }
}
