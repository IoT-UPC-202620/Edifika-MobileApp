import '../../../core/widgets/status_chip.dart';

int _int(Object? v) => (v as num?)?.toInt() ?? 0;

/// `GET /access/me/doors`: puertas a las que puede entrar el residente.
class AccessDoor {
  const AccessDoor({
    required this.deviceId,
    required this.deviceCode,
    required this.name,
    required this.location,
    required this.status,
    required this.canEnter,
  });

  factory AccessDoor.fromJson(Map<String, dynamic> json) => AccessDoor(
        deviceId: _int(json['deviceId']),
        deviceCode: json['deviceCode'] as String? ?? '',
        name: json['name'] as String? ?? '',
        location: json['location'] as String? ?? '',
        status: json['status'] as String? ?? '',
        canEnter: json['canEnter'] as bool? ?? false,
      );

  final int deviceId;
  final String deviceCode;
  final String name;
  final String location;
  final String status;
  final bool canEnter;
}

/// `GET /access/me/credentials`: tarjetas RFID del residente.
class MyCredential {
  const MyCredential({
    required this.id,
    required this.rfidUid,
    required this.status,
    this.suspensionReason,
    this.validUntil,
  });

  factory MyCredential.fromJson(Map<String, dynamic> json) => MyCredential(
        id: _int(json['id']),
        rfidUid: json['rfidUid'] as String? ?? '',
        status: json['status'] as String? ?? '',
        suspensionReason: json['suspensionReason'] as String?,
        validUntil: json['validUntil'] as String?,
      );

  final int id;
  final String rfidUid;
  final String status;
  final String? suspensionReason;
  final String? validUntil;
}

/// `GET /access/me/attempts` y `GET /access/attempts`: intentos de acceso.
class AccessAttempt {
  const AccessAttempt({
    required this.id,
    required this.deviceCode,
    required this.result,
    required this.reason,
    required this.occurredAt,
    this.rfidUidMasked,
    this.userId,
  });

  factory AccessAttempt.fromJson(Map<String, dynamic> json) => AccessAttempt(
        id: _int(json['id']),
        deviceCode: json['deviceCode'] as String? ?? '',
        result: json['result'] as String? ?? '',
        reason: json['reason'] as String? ?? '',
        occurredAt: json['occurredAt'] as String? ?? '',
        rfidUidMasked: json['rfidUidMasked'] as String?,
        userId: (json['userId'] as num?)?.toInt(),
      );

  final int id;
  final String deviceCode;
  final String result;
  final String reason;
  final String occurredAt;
  final String? rfidUidMasked;
  final int? userId;

  bool get granted => result.toUpperCase() == 'GRANTED';
}

/// Textos de presentacion (mismo criterio que la web).
class AccessLabels {
  const AccessLabels._();

  static String reason(String reason) => switch (reason.toUpperCase()) {
        'GRANTED' => 'Acceso concedido',
        'NOT_REGISTERED' => 'Credencial no registrada',
        'SUSPENDED' => 'Credencial suspendida',
        'DELINQUENT' => 'Residente con deuda',
        'REVOKED' => 'Credencial revocada',
        'EXPIRED' => 'Credencial vencida',
        'NOT_AUTHORIZED' => 'No autorizado',
        'MAINTENANCE' => 'Área en mantenimiento',
        'OUT_OF_SCHEDULE' => 'Fuera del horario autorizado',
        'UNSUPPORTED' => 'No soportado',
        _ => reason,
      };

  static (String, StatusTone) credentialStatus(String status) => switch (status.toUpperCase()) {
        'ACTIVE' => ('Activa', StatusTone.success),
        'SUSPENDED' => ('Suspendida', StatusTone.pending),
        'LOST' => ('Reportada perdida', StatusTone.danger),
        'REVOKED' => ('Revocada', StatusTone.danger),
        'EXPIRED' => ('Vencida', StatusTone.neutral),
        _ => (status, StatusTone.neutral),
      };
}
