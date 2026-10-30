import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// Recurso `/users/:id` (modelo `User` del web).
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required String fullName,
    required String email,
    @Default('') String phone,
    @Default('') String status,
    @Default('') String documentType,
    @Default('') String documentNumber,
    @Default(<String>[]) List<String> roles,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}
