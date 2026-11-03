// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iot_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IotGateway _$IotGatewayFromJson(Map<String, dynamic> json) => _IotGateway(
  id: (json['id'] as num).toInt(),
  gatewayCode: json['gatewayCode'] as String,
  buildingId: (json['buildingId'] as num).toInt(),
  name: json['name'] as String,
  status: json['status'] as String,
  syncVersion: (json['syncVersion'] as num?)?.toInt() ?? 0,
  lastSyncAt: json['lastSyncAt'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$IotGatewayToJson(_IotGateway instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gatewayCode': instance.gatewayCode,
      'buildingId': instance.buildingId,
      'name': instance.name,
      'status': instance.status,
      'syncVersion': instance.syncVersion,
      'lastSyncAt': instance.lastSyncAt,
      'createdAt': instance.createdAt,
    };

_IotDevice _$IotDeviceFromJson(Map<String, dynamic> json) => _IotDevice(
  id: (json['id'] as num).toInt(),
  deviceCode: json['deviceCode'] as String,
  gatewayId: (json['gatewayId'] as num).toInt(),
  gatewayCode: json['gatewayCode'] as String? ?? '',
  buildingId: (json['buildingId'] as num).toInt(),
  name: json['name'] as String,
  location: json['location'] as String? ?? '',
  deviceType: json['deviceType'] as String? ?? 'DOOR',
  capabilities:
      (json['capabilities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  accessMode: json['accessMode'] as String? ?? 'FREE_ACCESS',
  activeReservationId: (json['activeReservationId'] as num?)?.toInt(),
  ledColor: json['ledColor'] as String?,
  unlockSeconds: (json['unlockSeconds'] as num?)?.toInt() ?? 0,
  firmwareVersion: json['firmwareVersion'] as String?,
  status: json['status'] as String,
  lastSeenAt: json['lastSeenAt'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$IotDeviceToJson(_IotDevice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceCode': instance.deviceCode,
      'gatewayId': instance.gatewayId,
      'gatewayCode': instance.gatewayCode,
      'buildingId': instance.buildingId,
      'name': instance.name,
      'location': instance.location,
      'deviceType': instance.deviceType,
      'capabilities': instance.capabilities,
      'accessMode': instance.accessMode,
      'activeReservationId': instance.activeReservationId,
      'ledColor': instance.ledColor,
      'unlockSeconds': instance.unlockSeconds,
      'firmwareVersion': instance.firmwareVersion,
      'status': instance.status,
      'lastSeenAt': instance.lastSeenAt,
      'createdAt': instance.createdAt,
    };

_DoorReservation _$DoorReservationFromJson(Map<String, dynamic> json) =>
    _DoorReservation(
      id: (json['id'] as num).toInt(),
      deviceId: (json['deviceId'] as num).toInt(),
      holderUserId: (json['holderUserId'] as num).toInt(),
      startsAt: json['startsAt'] as String,
      endsAt: json['endsAt'] as String,
      status: json['status'] as String,
      authorizedUserIds:
          (json['authorizedUserIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      createdBy: (json['createdBy'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$DoorReservationToJson(_DoorReservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'holderUserId': instance.holderUserId,
      'startsAt': instance.startsAt,
      'endsAt': instance.endsAt,
      'status': instance.status,
      'authorizedUserIds': instance.authorizedUserIds,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
    };

_DeviceCommand _$DeviceCommandFromJson(Map<String, dynamic> json) =>
    _DeviceCommand(
      commandId: json['commandId'] as String,
      deviceId: (json['deviceId'] as num).toInt(),
      type: json['type'] as String,
      params:
          json['params'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      status: json['status'] as String,
      detail: json['detail'] as String?,
      requestedAt: json['requestedAt'] as String?,
      expiresAt: json['expiresAt'] as String?,
      resolvedAt: json['resolvedAt'] as String?,
    );

Map<String, dynamic> _$DeviceCommandToJson(_DeviceCommand instance) =>
    <String, dynamic>{
      'commandId': instance.commandId,
      'deviceId': instance.deviceId,
      'type': instance.type,
      'params': instance.params,
      'status': instance.status,
      'detail': instance.detail,
      'requestedAt': instance.requestedAt,
      'expiresAt': instance.expiresAt,
      'resolvedAt': instance.resolvedAt,
    };

_DiscoveredDevice _$DiscoveredDeviceFromJson(Map<String, dynamic> json) =>
    _DiscoveredDevice(
      id: (json['id'] as num).toInt(),
      deviceCode: json['deviceCode'] as String,
      gatewayId: (json['gatewayId'] as num).toInt(),
      gatewayCode: json['gatewayCode'] as String? ?? '',
      buildingId: (json['buildingId'] as num).toInt(),
      mac: json['mac'] as String? ?? '',
      firmware: json['firmware'] as String? ?? '',
      model: json['model'] as String?,
      capabilities:
          (json['capabilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      ip: json['ip'] as String?,
      rssi: (json['rssi'] as num?)?.toInt(),
      pairingCode: json['pairingCode'] as String? ?? '',
      status: json['status'] as String? ?? 'PENDING',
      deviceId: (json['deviceId'] as num?)?.toInt(),
      firstSeenAt: json['firstSeenAt'] as String?,
      lastSeenAt: json['lastSeenAt'] as String?,
    );

Map<String, dynamic> _$DiscoveredDeviceToJson(_DiscoveredDevice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceCode': instance.deviceCode,
      'gatewayId': instance.gatewayId,
      'gatewayCode': instance.gatewayCode,
      'buildingId': instance.buildingId,
      'mac': instance.mac,
      'firmware': instance.firmware,
      'model': instance.model,
      'capabilities': instance.capabilities,
      'ip': instance.ip,
      'rssi': instance.rssi,
      'pairingCode': instance.pairingCode,
      'status': instance.status,
      'deviceId': instance.deviceId,
      'firstSeenAt': instance.firstSeenAt,
      'lastSeenAt': instance.lastSeenAt,
    };

_ExistingCardCredential _$ExistingCardCredentialFromJson(
  Map<String, dynamic> json,
) => _ExistingCardCredential(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num?)?.toInt(),
  holderName: json['holderName'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$ExistingCardCredentialToJson(
  _ExistingCardCredential instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'holderName': instance.holderName,
  'status': instance.status,
};

_CardEnrollment _$CardEnrollmentFromJson(Map<String, dynamic> json) =>
    _CardEnrollment(
      id: (json['id'] as num).toInt(),
      deviceId: (json['deviceId'] as num).toInt(),
      deviceCode: json['deviceCode'] as String,
      buildingId: (json['buildingId'] as num).toInt(),
      status: json['status'] as String,
      startedAt: json['startedAt'] as String,
      expiresAt: json['expiresAt'] as String,
      capturedUid: json['capturedUid'] as String?,
      capturedAt: json['capturedAt'] as String?,
      existingCredential: json['existingCredential'] == null
          ? null
          : ExistingCardCredential.fromJson(
              json['existingCredential'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$CardEnrollmentToJson(_CardEnrollment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'deviceCode': instance.deviceCode,
      'buildingId': instance.buildingId,
      'status': instance.status,
      'startedAt': instance.startedAt,
      'expiresAt': instance.expiresAt,
      'capturedUid': instance.capturedUid,
      'capturedAt': instance.capturedAt,
      'existingCredential': instance.existingCredential,
    };

_AccessCredential _$AccessCredentialFromJson(Map<String, dynamic> json) =>
    _AccessCredential(
      id: (json['id'] as num).toInt(),
      rfidUid: json['rfidUid'] as String,
      buildingId: (json['buildingId'] as num).toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      holderName: json['holderName'] as String?,
      status: json['status'] as String,
      suspensionReason: json['suspensionReason'] as String?,
      validFrom: json['validFrom'] as String?,
      validUntil: json['validUntil'] as String?,
      origin: json['origin'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$AccessCredentialToJson(_AccessCredential instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rfidUid': instance.rfidUid,
      'buildingId': instance.buildingId,
      'userId': instance.userId,
      'holderName': instance.holderName,
      'status': instance.status,
      'suspensionReason': instance.suspensionReason,
      'validFrom': instance.validFrom,
      'validUntil': instance.validUntil,
      'origin': instance.origin,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_SensorReading _$SensorReadingFromJson(Map<String, dynamic> json) =>
    _SensorReading(
      magnitude: json['magnitude'] as String,
      value: (json['value'] as num?)?.toDouble(),
      unit: json['unit'] as String? ?? '',
      capturedAt: json['capturedAt'] as String?,
    );

Map<String, dynamic> _$SensorReadingToJson(_SensorReading instance) =>
    <String, dynamic>{
      'magnitude': instance.magnitude,
      'value': instance.value,
      'unit': instance.unit,
      'capturedAt': instance.capturedAt,
    };

_DeviceTelemetry _$DeviceTelemetryFromJson(Map<String, dynamic> json) =>
    _DeviceTelemetry(
      deviceCode: json['deviceCode'] as String,
      deviceId: (json['deviceId'] as num?)?.toInt(),
      name: json['name'] as String? ?? '',
      buildingId: (json['buildingId'] as num?)?.toInt(),
      connectionStatus: json['connectionStatus'] as String? ?? 'OFFLINE',
      lastHeartbeatAt: json['lastHeartbeatAt'] as String?,
      latest:
          (json['latest'] as List<dynamic>?)
              ?.map((e) => SensorReading.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SensorReading>[],
    );

Map<String, dynamic> _$DeviceTelemetryToJson(_DeviceTelemetry instance) =>
    <String, dynamic>{
      'deviceCode': instance.deviceCode,
      'deviceId': instance.deviceId,
      'name': instance.name,
      'buildingId': instance.buildingId,
      'connectionStatus': instance.connectionStatus,
      'lastHeartbeatAt': instance.lastHeartbeatAt,
      'latest': instance.latest,
    };
