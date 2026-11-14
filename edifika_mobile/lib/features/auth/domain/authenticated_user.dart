import 'package:freezed_annotation/freezed_annotation.dart';

part 'authenticated_user.freezed.dart';
part 'authenticated_user.g.dart';

/// Respuesta de `POST /authentication/sign-in`.
@freezed
abstract class AuthenticatedUser with _$AuthenticatedUser {
  const AuthenticatedUser._();

  const factory AuthenticatedUser({
    required int id,
    required String email,
    required String token,
    @Default('') String fullName,
    @Default(<String>[]) List<String> roles,
    int? buildingId,
  }) = _AuthenticatedUser;

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) => _$AuthenticatedUserFromJson(json);

  Set<String> get _normalizedRoles => roles.map(normalizeRole).toSet();

  /// Propietario (OWNER) o inquilino (TENANT): usa las pantallas del residente.
  bool get isResident => _normalizedRoles.any(const {'OWNER', 'TENANT'}.contains);

  /// Propietario: ve tambien "Cuenta" (deudas y pagos).
  bool get isOwner => _normalizedRoles.contains('OWNER');

  /// Inquilino sin rol de propietario: sin pestaña "Cuenta".
  bool get isTenantOnly => _normalizedRoles.contains('TENANT') && !isOwner && !isAdmin;

  /// Administrador del edificio: inicio con resumen y gestión IoT.
  bool get isAdmin => _normalizedRoles.contains('ADMIN');

  /// La app móvil admite residentes y administradores; cualquier otro rol
  /// (o un usuario sin roles) no puede ingresar.
  bool get canUseMobileApp => isAdmin || isResident;
}

/// `ROLE_admin` → `ADMIN` (Spring Security antepone `ROLE_` a los roles).
String normalizeRole(String role) {
  final upper = role.trim().toUpperCase();
  return upper.startsWith('ROLE_') ? upper.substring(5) : upper;
}
