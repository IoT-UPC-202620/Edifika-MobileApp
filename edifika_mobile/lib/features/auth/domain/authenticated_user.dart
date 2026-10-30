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

  /// La app móvil es para residentes: propietarios (OWNER) o inquilinos (TENANT).
  bool get isResident => roles.any((role) => const {'OWNER', 'TENANT'}.contains(role.toUpperCase()));
}
