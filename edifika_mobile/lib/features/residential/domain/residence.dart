import 'residential_models.dart';

/// Edificio y unidad activa del residente que inició sesión.
class Residence {
  const Residence({required this.building, this.unit, this.relationType = ''});

  final Building building;
  final Unit? unit;

  /// OWNER o TENANT (de /residents/me).
  final String relationType;

  bool get isTenant => relationType.toUpperCase() == 'TENANT';

  /// Texto bajo el título de cada pantalla: "Edificio Los Olivos · Departamento 102".
  String get location => unit == null ? building.name : '${building.name} · Departamento ${unit!.unitNumber}';
}
