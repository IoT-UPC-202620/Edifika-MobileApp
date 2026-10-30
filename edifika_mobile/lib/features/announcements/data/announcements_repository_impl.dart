import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../domain/announcement.dart';
import '../domain/announcements_repository.dart';

class AnnouncementsRepositoryImpl implements AnnouncementsRepository {
  AnnouncementsRepositoryImpl(this._dio);

  final Dio _dio;

  /// Igual que `AnnouncementsService.getByBuildingId` del web.
  @override
  Future<List<Announcement>> getByBuilding(int buildingId) => guardApiCall(() async {
        final response = await _dio.get<Object>(
          ApiEndpoints.announcements,
          queryParameters: {'buildingId': buildingId},
        );
        return parseList(response.data, Announcement.fromJson);
      });

  @override
  Future<List<AnnouncementRead>> getReadsByUser(int userId) => guardApiCall(() async {
        final response = await _dio.get<Object>(
          ApiEndpoints.announcementReads,
          queryParameters: {'id_user': userId},
        );
        return parseList(response.data, AnnouncementRead.fromJson);
      });

  @override
  Future<AnnouncementRead> confirmRead({required int announcementId, required int userId}) =>
      guardApiCall(() async {
        final response = await _dio.post<Map<String, dynamic>>(
          ApiEndpoints.announcementReads,
          data: {'id_announcement': announcementId, 'id_user': userId},
        );
        return AnnouncementRead.fromJson(response.data!);
      });
}
