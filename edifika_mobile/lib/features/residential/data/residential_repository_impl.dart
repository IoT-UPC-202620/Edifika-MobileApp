import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../domain/residential_models.dart';
import '../domain/residential_repository.dart';

class ResidentialRepositoryImpl implements ResidentialRepository {
  ResidentialRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Building>> getBuildings() => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.buildings);
        return parseList(response.data, Building.fromJson);
      });

  @override
  Future<Building> getBuilding(int buildingId) => guardApiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>('${ApiEndpoints.buildings}/$buildingId');
        return Building.fromJson(response.data!);
      });

  @override
  Future<Unit> getUnit(int unitId) => guardApiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>('${ApiEndpoints.units}/$unitId');
        return Unit.fromJson(response.data!);
      });

  @override
  Future<List<UserUnit>> getBuildingResidents(int buildingId) => guardApiCall(() async {
        final response = await _dio.get<Object>('${ApiEndpoints.buildings}/$buildingId/residents');
        return parseList(response.data, UserUnit.fromJson);
      });

  /// Usa la misma ruta que `UserUnitsService.getResidentsByBuildingId` del web.
  @override
  Future<UserUnit?> getActiveUserUnit({required int buildingId, required int userId}) async {
    final relations = await getBuildingResidents(buildingId);
    for (final relation in relations) {
      if (relation.idUser == userId && relation.isActive) return relation;
    }
    return null;
  }
}
