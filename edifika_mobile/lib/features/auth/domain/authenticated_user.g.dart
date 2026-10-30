// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticated_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthenticatedUser _$AuthenticatedUserFromJson(Map<String, dynamic> json) =>
    _AuthenticatedUser(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      token: json['token'] as String,
      fullName: json['fullName'] as String? ?? '',
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      buildingId: (json['buildingId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthenticatedUserToJson(_AuthenticatedUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'token': instance.token,
      'fullName': instance.fullName,
      'roles': instance.roles,
      'buildingId': instance.buildingId,
    };
