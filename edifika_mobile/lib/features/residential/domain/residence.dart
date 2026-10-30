import 'residential_models.dart';

/// Edificio y unidad activa del residente que inició sesión.
class Residence {
  const Residence({required this.building, this.unit});

  final Building building;
  final Unit? unit;

  /// Texto bajo el título de cada pantalla: "Edificio Los Olivos · Departamento 102".
  String get location => unit == null ? building.name : '${building.name} · Departamento ${unit!.unitNumber}';
}
