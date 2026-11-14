import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement.freezed.dart';
part 'announcement.g.dart';

/// `GET /announcements?buildingId=` de Communications (`id`, `buildingId`, `createdAt`).
/// Acepta tambien las claves snake_case de la fake API.
@freezed
abstract class Announcement with _$Announcement {
  const factory Announcement({
    @JsonKey(readValue: _readId) required int id,
    @JsonKey(readValue: _readBuildingId) required int buildingId,
    required String title,
    @Default('') String description,
    @Default('') String message,
    @Default('') String priority,
    @JsonKey(readValue: _readCreatedAt) String? createdAt,
  }) = _Announcement;

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);
}

/// Confirmación de lectura (`/announcement-reads`), modelo `AnnouncementRead` del web.
@freezed
abstract class AnnouncementRead with _$AnnouncementRead {
  const factory AnnouncementRead({
    @JsonKey(name: 'id_announcement_read') required int id,
    @JsonKey(name: 'id_announcement') required int announcementId,
    @JsonKey(name: 'id_user') required int userId,
  }) = _AnnouncementRead;

  factory AnnouncementRead.fromJson(Map<String, dynamic> json) => _$AnnouncementReadFromJson(json);
}

Object? _readId(Map<dynamic, dynamic> json, String key) => json['id'] ?? json['id_announcement'];

Object? _readBuildingId(Map<dynamic, dynamic> json, String key) => json['buildingId'] ?? json['id_building'];

Object? _readCreatedAt(Map<dynamic, dynamic> json, String key) => json['createdAt'] ?? json['created_at'];
