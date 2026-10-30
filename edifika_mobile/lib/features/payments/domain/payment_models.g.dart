// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Debt _$DebtFromJson(Map<String, dynamic> json) => _Debt(
  id: (json['id'] as num).toInt(),
  unitId: (json['unitId'] as num).toInt(),
  description: json['description'] as String,
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String? ?? 'PEN',
  dueDate: json['dueDate'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$DebtToJson(_Debt instance) => <String, dynamic>{
  'id': instance.id,
  'unitId': instance.unitId,
  'description': instance.description,
  'amount': instance.amount,
  'currency': instance.currency,
  'dueDate': instance.dueDate,
  'status': instance.status,
};

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  id: (json['id'] as num).toInt(),
  debtId: (json['debtId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String? ?? 'PEN',
  paymentDate: json['paymentDate'] as String,
  paymentMethod: json['paymentMethod'] as String? ?? '',
  status: json['status'] as String,
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'id': instance.id,
  'debtId': instance.debtId,
  'userId': instance.userId,
  'amount': instance.amount,
  'currency': instance.currency,
  'paymentDate': instance.paymentDate,
  'paymentMethod': instance.paymentMethod,
  'status': instance.status,
};
