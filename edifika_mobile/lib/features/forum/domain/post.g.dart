// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  content: json['content'] as String,
  residentId: (json['residentId'] as num).toInt(),
  imageUrl: json['imageUrl'] as String?,
  createdAt: json['createdAt'] as String?,
  authorRole: json['authorRole'] as String?,
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'residentId': instance.residentId,
  'imageUrl': instance.imageUrl,
  'createdAt': instance.createdAt,
  'authorRole': instance.authorRole,
};
