import 'package:freezed_annotation/freezed_annotation.dart';

part 'residential_models.freezed.dart';
part 'residential_models.g.dart';

/// La fake API envía `id` (y también `idBuilding`); el microservicio
/// Residential Management solo envía `idBuilding`, `idUnit` e `idUserUnit`.
Object? _readBuildingId(Map<dynamic, dynamic> json, String key) => json['id'] ?? json['idBuilding'];
Object? _readUnitId(Map<dynamic, dynamic> json, String key) => json['id'] ?? json['idUnit'];
Object? _readUserUnitId(Map<dynamic, dynamic> json, String key) => json['id'] ?? json['idUserUnit'];

@freezed
abstract class Building with _$Building {
  const factory Building({
    @JsonKey(readValue: _readBuildingId) required int id,
    required String name,
    @Default('') String address,
    @Default('') String district,
    @Default('') String city,
  }) = _Building;

  factory Building.fromJson(Map<String, dynamic> json) => _$BuildingFromJson(json);
}

@freezed
abstract class Unit with _$Unit {
  const factory Unit({
    @JsonKey(readValue: _readUnitId) required int id,
    required int idBuilding,
    required int unitNumber,
    required int floor,
    @Default(0) double coveredArea,
    @Default(0) double totalArea,
    @Default(0) double participationPercentage,
    @Default('') String status,
  }) = _Unit;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);
}

/// Relación residente ↔ unidad (`/residential/user-units`).
@freezed
abstract class UserUnit with _$UserUnit {
  const UserUnit._();

  const factory UserUnit({
    @JsonKey(readValue: _readUserUnitId) required int id,
    required int idUnit,
    required int idUser,
    int? idBuilding,
    String? startDate,
    String? endDate,
    @Default('') String status,
  }) = _UserUnit;

  factory UserUnit.fromJson(Map<String, dynamic> json) => _$UserUnitFromJson(json);

  bool get isActive => status.toUpperCase() == 'ACTIVE';
}
