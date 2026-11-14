import 'residential_models.dart';
import 'my_residence.dart';

abstract class ResidentialRepository {
  /// Todos los edificios (`GET /residential/buildings`). Lo usa el administrador.
  Future<List<Building>> getBuildings();

  Future<Building> getBuilding(int buildingId);

  Future<Unit> getUnit(int unitId);

  /// Relaciones residente ↔ unidad del edificio (`GET /residential/buildings/{id}/residents`).
  Future<List<UserUnit>> getBuildingResidents(int buildingId);

  /// Unidad activa del usuario del token (`GET /residential/residents/me`).
  /// Lanza ApiException 404 si no tiene unidad asignada.
  Future<MyResidence> getMyResidence();
}
