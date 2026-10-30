import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_models.freezed.dart';
part 'payment_models.g.dart';

@freezed
abstract class Debt with _$Debt {
  const Debt._();

  const factory Debt({
    required int id,
    required int unitId,
    required String description,
    required double amount,
    @Default('PEN') String currency,
    required String dueDate,
    required String status,
  }) = _Debt;

  factory Debt.fromJson(Map<String, dynamic> json) => _$DebtFromJson(json);

  bool get isPending => status.toUpperCase() == 'PENDING';

  /// Misma regla que el reporte financiero de la fake API: pendiente y vencida.
  bool isOverdue(DateTime now) {
    final due = DateTime.tryParse(dueDate);
    return isPending && due != null && due.isBefore(now);
  }
}

@freezed
abstract class Payment with _$Payment {
  const factory Payment({
    required int id,
    required int debtId,
    required int userId,
    required double amount,
    @Default('PEN') String currency,
    required String paymentDate,
    @Default('') String paymentMethod,
    required String status,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
}
