// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Announcement _$AnnouncementFromJson(Map<String, dynamic> json) =>
    _Announcement(
      id: (_readId(json, 'id') as num).toInt(),
      buildingId: (_readBuildingId(json, 'buildingId') as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      message: json['message'] as String? ?? '',
      priority: json['priority'] as String? ?? '',
      createdAt: _readCreatedAt(json, 'createdAt') as String?,
    );

Map<String, dynamic> _$AnnouncementToJson(_Announcement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buildingId': instance.buildingId,
      'title': instance.title,
      'description': instance.description,
      'message': instance.message,
      'priority': instance.priority,
      'createdAt': instance.createdAt,
    };

_AnnouncementRead _$AnnouncementReadFromJson(Map<String, dynamic> json) =>
    _AnnouncementRead(
      id: (json['id_announcement_read'] as num).toInt(),
      announcementId: (json['id_announcement'] as num).toInt(),
      userId: (json['id_user'] as num).toInt(),
    );

Map<String, dynamic> _$AnnouncementReadToJson(_AnnouncementRead instance) =>
    <String, dynamic>{
      'id_announcement_read': instance.id,
      'id_announcement': instance.announcementId,
      'id_user': instance.userId,
    };
