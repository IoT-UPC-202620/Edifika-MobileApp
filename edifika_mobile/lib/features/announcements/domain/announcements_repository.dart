import 'announcement.dart';

/// PENDIENTE DE INTEGRACIÓN: la fake API aún no expone estas rutas, así que
/// hoy las llamadas terminan en `ApiException` (404).
abstract class AnnouncementsRepository {
  Future<List<Announcement>> getByBuilding(int buildingId);

  Future<List<AnnouncementRead>> getReadsByUser(int userId);

  Future<AnnouncementRead> confirmRead({required int announcementId, required int userId});
}
