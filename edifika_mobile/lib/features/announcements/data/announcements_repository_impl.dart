import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/events/data_changes.dart';
import '../../../core/network/api_client.dart';
import '../domain/announcement.dart';
import '../domain/announcements_repository.dart';

class AnnouncementsRepositoryImpl implements AnnouncementsRepository {
  AnnouncementsRepositoryImpl(this._dio, [this._changes]);

  final Dio _dio;
  final DataChanges? _changes;

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
  Future<void> confirmRead({required int announcementId, required int userId}) => guardApiCall(() async {
        await _dio.post<Object>(ApiEndpoints.announcementRead(announcementId), data: {'userId': userId});
        _changes?.notify();
      });
}
