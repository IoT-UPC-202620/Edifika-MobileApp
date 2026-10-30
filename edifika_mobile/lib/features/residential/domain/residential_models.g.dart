// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residential_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Building _$BuildingFromJson(Map<String, dynamic> json) => _Building(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  address: json['address'] as String? ?? '',
  district: json['district'] as String? ?? '',
  city: json['city'] as String? ?? '',
);

Map<String, dynamic> _$BuildingToJson(_Building instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'district': instance.district,
  'city': instance.city,
};

_Unit _$UnitFromJson(Map<String, dynamic> json) => _Unit(
  id: (json['id'] as num).toInt(),
  idBuilding: (json['idBuilding'] as num).toInt(),
  unitNumber: (json['unitNumber'] as num).toInt(),
  floor: (json['floor'] as num).toInt(),
  coveredArea: (json['coveredArea'] as num?)?.toDouble() ?? 0,
  totalArea: (json['totalArea'] as num?)?.toDouble() ?? 0,
  participationPercentage:
      (json['participationPercentage'] as num?)?.toDouble() ?? 0,
  status: json['status'] as String? ?? '',
);

Map<String, dynamic> _$UnitToJson(_Unit instance) => <String, dynamic>{
  'id': instance.id,
  'idBuilding': instance.idBuilding,
  'unitNumber': instance.unitNumber,
  'floor': instance.floor,
  'coveredArea': instance.coveredArea,
  'totalArea': instance.totalArea,
  'participationPercentage': instance.participationPercentage,
  'status': instance.status,
};

_UserUnit _$UserUnitFromJson(Map<String, dynamic> json) => _UserUnit(
  id: (json['id'] as num).toInt(),
  idUnit: (json['idUnit'] as num).toInt(),
  idUser: (json['idUser'] as num).toInt(),
  idBuilding: (json['idBuilding'] as num?)?.toInt(),
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  status: json['status'] as String? ?? '',
);

Map<String, dynamic> _$UserUnitToJson(_UserUnit instance) => <String, dynamic>{
  'id': instance.id,
  'idUnit': instance.idUnit,
  'idUser': instance.idUser,
  'idBuilding': instance.idBuilding,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'status': instance.status,
};
