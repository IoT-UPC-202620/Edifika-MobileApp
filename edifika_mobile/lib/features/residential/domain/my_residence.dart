/// Respuesta de `GET /residential/residents/me`: unidad activa del residente.
class MyResidence {
  const MyResidence({
    required this.buildingId,
    required this.buildingName,
    required this.unitId,
    required this.unitNumber,
    required this.relationType,
  });

  factory MyResidence.fromJson(Map<String, dynamic> json) => MyResidence(
        buildingId: (json['buildingId'] as num).toInt(),
        buildingName: json['buildingName'] as String? ?? '',
        unitId: (json['unitId'] as num).toInt(),
        unitNumber: (json['unitNumber'] as num?)?.toInt() ?? 0,
        relationType: json['relationType'] as String? ?? '',
      );

  final int buildingId;
  final String buildingName;
  final int unitId;
  final int unitNumber;

  /// OWNER o TENANT.
  final String relationType;
}
