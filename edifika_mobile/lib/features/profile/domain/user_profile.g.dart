// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: (json['id'] as num).toInt(),
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String? ?? '',
  status: json['status'] as String? ?? '',
  documentType: json['documentType'] as String? ?? '',
  documentNumber: json['documentNumber'] as String? ?? '',
  roles:
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'status': instance.status,
      'documentType': instance.documentType,
      'documentNumber': instance.documentNumber,
      'roles': instance.roles,
    };
