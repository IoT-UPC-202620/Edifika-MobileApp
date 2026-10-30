import 'app_notification.dart';

abstract class NotificationsRepository {
  Future<List<AppNotification>> getByUser(int userId);

  Future<AppNotification> markAsRead(int notificationId);
}
