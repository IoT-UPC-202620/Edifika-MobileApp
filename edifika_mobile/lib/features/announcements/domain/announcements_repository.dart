import 'announcement.dart';

/// Anuncios del edificio (Communications). El backend no expone la lista de
/// lecturas por usuario: el estado "leído" solo se conoce tras confirmar.
abstract class AnnouncementsRepository {
  Future<List<Announcement>> getByBuilding(int buildingId);

  /// `POST /announcements/{id}/read` con `{userId}`. Si ya estaba leído el backend responde error.
  Future<void> confirmRead({required int announcementId, required int userId});
}
