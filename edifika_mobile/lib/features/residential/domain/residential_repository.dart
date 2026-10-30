import 'residential_models.dart';

abstract class ResidentialRepository {
  Future<Building> getBuilding(int buildingId);

  Future<Unit> getUnit(int unitId);

  /// Unidad activa del residente en su edificio, o `null` si no tiene.
  Future<UserUnit?> getActiveUserUnit({required int buildingId, required int userId});
}
