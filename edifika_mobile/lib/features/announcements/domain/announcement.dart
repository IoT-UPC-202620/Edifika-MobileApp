import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement.freezed.dart';
part 'announcement.g.dart';

/// Contrato tomado del modelo `Announcement` del frontend web.
/// PENDIENTE DE INTEGRACIÓN: la fake API no tiene la colección `announcements`.
@freezed
abstract class Announcement with _$Announcement {
  const factory Announcement({
    @JsonKey(name: 'id_announcement') required int id,
    @JsonKey(name: 'id_building') required int buildingId,
    required String title,
    @Default('') String description,
    @Default('') String message,
    @Default('') String priority,
    @JsonKey(name: 'created_at') String? createdAt,
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
