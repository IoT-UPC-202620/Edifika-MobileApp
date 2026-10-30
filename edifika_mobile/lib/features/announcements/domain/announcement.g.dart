// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Announcement _$AnnouncementFromJson(Map<String, dynamic> json) =>
    _Announcement(
      id: (json['id_announcement'] as num).toInt(),
      buildingId: (json['id_building'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      message: json['message'] as String? ?? '',
      priority: json['priority'] as String? ?? '',
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$AnnouncementToJson(_Announcement instance) =>
    <String, dynamic>{
      'id_announcement': instance.id,
      'id_building': instance.buildingId,
      'title': instance.title,
      'description': instance.description,
      'message': instance.message,
      'priority': instance.priority,
      'created_at': instance.createdAt,
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
