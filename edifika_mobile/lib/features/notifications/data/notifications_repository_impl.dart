import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../domain/app_notification.dart';
import '../domain/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<AppNotification>> getByUser(int userId) => guardApiCall(() async {
        final response = await _dio.get<Object>('${ApiEndpoints.notifications}/user/$userId');
        return parseList(response.data, AppNotification.fromJson);
      });

  @override
  Future<AppNotification> markAsRead(int notificationId) => guardApiCall(() async {
        final response = await _dio.patch<Map<String, dynamic>>('${ApiEndpoints.notifications}/$notificationId/read');
        return AppNotification.fromJson(response.data!);
      });
}
