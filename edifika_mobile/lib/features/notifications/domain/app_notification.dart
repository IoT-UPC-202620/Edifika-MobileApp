import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

/// Forma real que devuelve la fake API (`/notifications/user/:userId`).
/// Nota: el modelo `Notification` del web usa otros nombres
/// (`id_notification`, `message`, `sent_at`) que la fake API no envía.
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required int id,
    required int userId,
    required String title,
    required String content,
    @Default(false) bool read,
    String? createdAt,
    String? readAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
}
