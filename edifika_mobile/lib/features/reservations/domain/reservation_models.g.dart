// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommonAreaRule _$CommonAreaRuleFromJson(Map<String, dynamic> json) =>
    _CommonAreaRule(
      maxReservationHours: (json['maxReservationHours'] as num?)?.toInt() ?? 0,
      requiresPayment: json['requiresPayment'] as bool? ?? false,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      requiresGuarantee: json['requiresGuarantee'] as bool? ?? false,
      guaranteeAmount: (json['guaranteeAmount'] as num?)?.toDouble() ?? 0,
      allowCancellation: json['allowCancellation'] as bool? ?? true,
      penaltyHoursBefore: (json['penaltyHoursBefore'] as num?)?.toInt() ?? 0,
      penaltyAmount: (json['penaltyAmount'] as num?)?.toDouble() ?? 0,
      requiresApproval: json['requiresApproval'] as bool? ?? false,
    );

Map<String, dynamic> _$CommonAreaRuleToJson(_CommonAreaRule instance) =>
    <String, dynamic>{
      'maxReservationHours': instance.maxReservationHours,
      'requiresPayment': instance.requiresPayment,
      'price': instance.price,
      'requiresGuarantee': instance.requiresGuarantee,
      'guaranteeAmount': instance.guaranteeAmount,
      'allowCancellation': instance.allowCancellation,
      'penaltyHoursBefore': instance.penaltyHoursBefore,
      'penaltyAmount': instance.penaltyAmount,
      'requiresApproval': instance.requiresApproval,
    };

_CommonArea _$CommonAreaFromJson(Map<String, dynamic> json) => _CommonArea(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  type: json['type'] as String,
  status: json['status'] as String,
  maxCapacity: (json['maxCapacity'] as num?)?.toInt() ?? 0,
  bookingType: json['bookingType'] as String? ?? 'SHARED',
  rules: json['rules'] == null
      ? null
      : CommonAreaRule.fromJson(json['rules'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommonAreaToJson(_CommonArea instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'status': instance.status,
      'maxCapacity': instance.maxCapacity,
      'bookingType': instance.bookingType,
      'rules': instance.rules,
    };

_Reservation _$ReservationFromJson(Map<String, dynamic> json) => _Reservation(
  id: (json['id'] as num).toInt(),
  residentId: (json['residentId'] as num).toInt(),
  commonAreaId: (json['commonAreaId'] as num).toInt(),
  reservationDate: json['reservationDate'] as String,
  timeSlot: (json['timeSlot'] as num).toInt(),
  numberOfGuests: (json['numberOfGuests'] as num?)?.toInt() ?? 1,
  status: json['status'] as String,
  qrCodeAccess: json['qrCodeAccess'] as String? ?? '',
  penaltyApplied: json['penaltyApplied'] as bool? ?? false,
);

Map<String, dynamic> _$ReservationToJson(_Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'residentId': instance.residentId,
      'commonAreaId': instance.commonAreaId,
      'reservationDate': instance.reservationDate,
      'timeSlot': instance.timeSlot,
      'numberOfGuests': instance.numberOfGuests,
      'status': instance.status,
      'qrCodeAccess': instance.qrCodeAccess,
      'penaltyApplied': instance.penaltyApplied,
    };
