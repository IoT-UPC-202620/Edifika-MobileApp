import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../domain/residential_models.dart';
import '../domain/residential_repository.dart';

class ResidentialRepositoryImpl implements ResidentialRepository {
  ResidentialRepositoryImpl(this._dio);

  final Dio _dio;

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

  /// Usa la misma ruta que `UserUnitsService.getResidentsByBuildingId` del web.
  @override
  Future<UserUnit?> getActiveUserUnit({required int buildingId, required int userId}) => guardApiCall(() async {
        final response = await _dio.get<Object>('${ApiEndpoints.buildings}/$buildingId/residents');
        final relations = parseList(response.data, UserUnit.fromJson);
        for (final relation in relations) {
          if (relation.idUser == userId && relation.isActive) return relation;
        }
        return null;
      });
}
