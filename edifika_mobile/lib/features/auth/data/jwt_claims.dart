import 'dart:convert';

import '../domain/authenticated_user.dart';

/// Lee el payload de un JWT sin verificar la firma (eso lo hace el backend).
/// Devuelve `null` si el token no es un JWT (p. ej. los `fake-jwt-token-…`
/// de la fake API) o si no se puede decodificar.
Map<String, dynamic>? readJwtPayload(String token) {
  final parts = token.split('.');
  if (parts.length != 3) return null;
  try {
    final payload = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
    return payload is Map<String, dynamic> ? payload : null;
  } catch (_) {
    return null;
  }
}

/// Roles del claim `roles` (o `authorities`) que emite el microservicio IAM.
///
/// El IAM real responde a `sign-in` solo `{ id, email, token }`: los roles
/// viajan dentro del JWT. Se aceptan con o sin el prefijo `ROLE_` de Spring.
List<String> jwtRoles(String token) {
  final payload = readJwtPayload(token);
  final raw = payload?['roles'] ?? payload?['authorities'];
  if (raw is! List) return const [];
  return raw
      .map((role) => role is Map ? role['authority'] ?? role['name'] : role)
      .whereType<String>()
      .map(normalizeRole)
      .where((role) => role.isNotEmpty)
      .toList();
}
