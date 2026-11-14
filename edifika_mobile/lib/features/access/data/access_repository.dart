import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../iot/domain/iot_models.dart' show DeviceTelemetry;
import '../domain/access_models.dart';

/// Alerta de telemetria abierta (`GET /telemetry/alerts?state=RAISED`).
class TelemetryAlert {
  const TelemetryAlert({required this.id, required this.deviceCode, required this.kind, required this.occurredAt, this.message});

  factory TelemetryAlert.fromJson(Map<String, dynamic> json) {
    final details = json['details'];
    return TelemetryAlert(
      id: (json['id'] as num?)?.toInt() ?? 0,
      deviceCode: json['deviceCode'] as String? ?? '',
      kind: json['kind'] as String? ?? '',
      occurredAt: json['occurredAt'] as String? ?? '',
      message: details is Map<String, dynamic> ? details['message'] as String? : null,
    );
  }

  final int id;
  final String deviceCode;
  final String kind;
  final String occurredAt;
  final String? message;

  String get kindLabel => switch (kind) {
        'device_offline' => 'Dispositivo sin conexión',
        'sensor_fault_temperature' => 'Falla del sensor de temperatura',
        'sensor_fault_humidity' => 'Falla del sensor de humedad',
        _ => kind,
      };
}

/// Accesos del residente (`/access/me/*`) y lecturas del resumen del administrador.
class AccessRepository {
  AccessRepository(this._dio);

  final Dio _dio;

  Future<List<AccessDoor>> myDoors() => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.myDoors);
        return parseList(response.data, AccessDoor.fromJson);
      });

  Future<List<MyCredential>> myCredentials() => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.myCredentials);
        return parseList(response.data, MyCredential.fromJson);
      });

  Future<List<AccessAttempt>> myAttempts({int limit = 20}) => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.myAttempts, queryParameters: {'limit': limit});
        return parseList(response.data, AccessAttempt.fromJson);
      });

  // ---- Resumen del administrador ----

  Future<List<TelemetryAlert>> openAlerts() => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.telemetryAlerts, queryParameters: {'state': 'RAISED'});
        return parseList(response.data, TelemetryAlert.fromJson);
      });

  Future<List<AccessAttempt>> recentDenied({int limit = 5}) => guardApiCall(() async {
        final response = await _dio.get<Object>(
          ApiEndpoints.accessAttempts,
          queryParameters: {'result': 'DENIED', 'limit': limit},
        );
        return parseList(response.data, AccessAttempt.fromJson);
      });

  Future<List<DeviceTelemetry>> allDevices() => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.telemetryDevices);
        return parseList(response.data, DeviceTelemetry.fromJson);
      });
}
