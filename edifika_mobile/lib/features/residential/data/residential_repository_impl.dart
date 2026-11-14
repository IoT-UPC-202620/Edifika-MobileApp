import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../domain/my_residence.dart';
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

  @override
  Future<MyResidence> getMyResidence() => guardApiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>(ApiEndpoints.residentsMe);
        return MyResidence.fromJson(response.data!);
      });
}
