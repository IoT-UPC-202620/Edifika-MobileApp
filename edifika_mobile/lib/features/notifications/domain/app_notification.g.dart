// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      read: json['read'] as bool? ?? false,
      createdAt: json['createdAt'] as String?,
      readAt: json['readAt'] as String?,
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'content': instance.content,
      'read': instance.read,
      'createdAt': instance.createdAt,
      'readAt': instance.readAt,
    };
