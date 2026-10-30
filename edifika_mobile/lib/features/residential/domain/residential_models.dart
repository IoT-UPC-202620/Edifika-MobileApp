import 'package:freezed_annotation/freezed_annotation.dart';

part 'residential_models.freezed.dart';
part 'residential_models.g.dart';

@freezed
abstract class Building with _$Building {
  const factory Building({
    required int id,
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
    required int id,
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
    required int id,
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
