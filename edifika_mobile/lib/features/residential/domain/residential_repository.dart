import 'residential_models.dart';

abstract class ResidentialRepository {
  /// Todos los edificios (`GET /residential/buildings`). Lo usa el administrador.
  Future<List<Building>> getBuildings();

  Future<Building> getBuilding(int buildingId);

  Future<Unit> getUnit(int unitId);

  /// Relaciones residente ↔ unidad del edificio (`GET /residential/buildings/{id}/residents`).
  Future<List<UserUnit>> getBuildingResidents(int buildingId);

  /// Unidad activa del residente en su edificio, o `null` si no tiene.
  Future<UserUnit?> getActiveUserUnit({required int buildingId, required int userId});
}
