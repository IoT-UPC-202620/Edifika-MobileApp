import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../domain/iot_models.dart';
import '../domain/iot_repository.dart';

class IotRepositoryImpl implements IotRepository {
  IotRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<IotGateway>> getGateways(int buildingId) => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.iotGateways, queryParameters: {'buildingId': buildingId});
        return parseList(response.data, IotGateway.fromJson);
      });

  @override
  Future<List<IotDevice>> getDevices(int buildingId) => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.iotDevices, queryParameters: {'buildingId': buildingId});
        return parseList(response.data, IotDevice.fromJson);
      });

  @override
  Future<IotDevice> getDevice(int deviceId) => guardApiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>('${ApiEndpoints.iotDevices}/$deviceId');
        return IotDevice.fromJson(response.data!);
      });

  @override
  Future<List<DeviceTelemetry>> getTelemetry(int buildingId) => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.telemetryDevices, queryParameters: {'buildingId': buildingId});
        return parseList(response.data, DeviceTelemetry.fromJson);
      });

  @override
  Future<DeviceTelemetry> getDeviceTelemetry(String deviceCode) => guardApiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>(
          '${ApiEndpoints.telemetryDevices}/${Uri.encodeComponent(deviceCode)}/latest',
        );
        return DeviceTelemetry.fromJson(response.data!);
      });

  @override
  Future<DoorReservation> createReservation(int deviceId, {required DateTime startsAt, required DateTime endsAt}) =>
      guardApiCall(() async {
        final response = await _dio.post<Map<String, dynamic>>(
          '${ApiEndpoints.iotDevices}/$deviceId/reservations',
          // Instantes en UTC (`CreateReservationRequest` del contrato).
          data: {'startsAt': _utc(startsAt), 'endsAt': _utc(endsAt)},
        );
        return DoorReservation.fromJson(response.data!);
      });

  @override
  Future<DeviceCommand> setLedColor(int deviceId, String color) => guardApiCall(() async {
        final response = await _dio.put<Map<String, dynamic>>(
          '${ApiEndpoints.iotDevices}/$deviceId/led',
          data: {'color': color},
        );
        return DeviceCommand.fromJson(response.data!);
      });

  @override
  Future<DeviceCommand> getCommand(String commandId) => guardApiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>('${ApiEndpoints.iotDeviceCommands}/$commandId');
        return DeviceCommand.fromJson(response.data!);
      });

  @override
  Future<CardEnrollment> startEnrollment(int deviceId) => guardApiCall(() async {
        final response = await _dio.post<Map<String, dynamic>>('${ApiEndpoints.iotDevices}/$deviceId/enrollment');
        return CardEnrollment.fromJson(response.data!);
      });

  @override
  Future<CardEnrollment?> getEnrollment(int deviceId) => guardApiCall(() async {
        final response = await _dio.get<Object>('${ApiEndpoints.iotDevices}/$deviceId/enrollment');
        if (response.statusCode == 204 || response.data is! Map<String, dynamic>) return null;
        return CardEnrollment.fromJson(response.data! as Map<String, dynamic>);
      });

  @override
  Future<void> cancelEnrollment(int deviceId) => guardApiCall(() async {
        await _dio.delete<void>('${ApiEndpoints.iotDevices}/$deviceId/enrollment');
      });

  @override
  Future<AccessCredential> createCredential({
    required String rfidUid,
    required int buildingId,
    required int userId,
    required String holderName,
  }) =>
      guardApiCall(() async {
        final response = await _dio.post<Map<String, dynamic>>(
          ApiEndpoints.accessCredentials,
          data: {
            'rfidUid': rfidUid,
            'buildingId': buildingId,
            'userId': userId,
            'holderName': holderName,
          },
        );
        return AccessCredential.fromJson(response.data!);
      });

  @override
  Future<List<DiscoveredDevice>> getDiscoveredDevices(int buildingId) => guardApiCall(() async {
        final response =
            await _dio.get<Object>(ApiEndpoints.iotDiscoveredDevices, queryParameters: {'buildingId': buildingId});
        return parseList(response.data, DiscoveredDevice.fromJson);
      });

  @override
  Future<void> identifyDiscoveredDevice(int discoveredId, {int seconds = 10}) => guardApiCall(() async {
        await _dio.post<void>('${ApiEndpoints.iotDiscoveredDevices}/$discoveredId/identify', data: {'seconds': seconds});
      });

  @override
  Future<IotDevice> adoptDiscoveredDevice(
    int discoveredId, {
    required String name,
    required String location,
    required List<String> capabilities,
    required int unlockSeconds,
    String deviceType = 'DOOR',
  }) =>
      guardApiCall(() async {
        final response = await _dio.post<Map<String, dynamic>>(
          '${ApiEndpoints.iotDiscoveredDevices}/$discoveredId/adopt',
          data: {
            'name': name,
            'location': location,
            'deviceType': deviceType,
            'capabilities': capabilities,
            'unlockSeconds': unlockSeconds,
          },
        );
        return IotDevice.fromJson(response.data!);
      });

  @override
  Future<void> ignoreDiscoveredDevice(int discoveredId) => guardApiCall(() async {
        await _dio.post<void>('${ApiEndpoints.iotDiscoveredDevices}/$discoveredId/ignore');
      });

  @override
  Future<List<AccessCredential>> getCredentials(int buildingId) => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.accessCredentials, queryParameters: {'buildingId': buildingId});
        return parseList(response.data, AccessCredential.fromJson);
      });

  @override
  Future<AccessCredential> changeCredentialStatus(int credentialId, String status) => guardApiCall(() async {
        final response = await _dio.patch<Map<String, dynamic>>(
          '${ApiEndpoints.accessCredentials}/$credentialId/status',
          data: {'status': status},
        );
        return AccessCredential.fromJson(response.data!);
      });

  /// `2026-11-01T23:30:00.000Z` sin microsegundos.
  static String _utc(DateTime value) {
    final utc = value.toUtc();
    return DateTime.utc(utc.year, utc.month, utc.day, utc.hour, utc.minute, utc.second).toIso8601String();
  }
}
