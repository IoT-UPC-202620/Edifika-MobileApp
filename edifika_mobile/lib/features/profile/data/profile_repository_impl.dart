import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../domain/profile_repository.dart';
import '../domain/user_profile.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<UserProfile> getProfile(int userId) => guardApiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>('${ApiEndpoints.users}/$userId');
        return UserProfile.fromJson(response.data!);
      });

  @override
  Future<UserProfile> updateProfile(UserProfile profile) => guardApiCall(() async {
        final response = await _dio.put<Map<String, dynamic>>(
          '${ApiEndpoints.users}/${profile.id}',
          data: profile.toJson(),
        );
        return UserProfile.fromJson(response.data!);
      });
}
