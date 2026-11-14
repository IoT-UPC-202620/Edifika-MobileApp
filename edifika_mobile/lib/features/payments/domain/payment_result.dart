/// Respuesta de `POST /payments` (PaymentResource del servicio Payment).
class PaymentResult {
  const PaymentResult({
    required this.id,
    required this.debtId,
    required this.amount,
    required this.currency,
    required this.status,
    this.paymentDate,
    this.declineReason,
    this.declineMessage,
  });

  factory PaymentResult.fromJson(Map<String, dynamic> json) => PaymentResult(
        id: (json['id'] as num).toInt(),
        debtId: (json['debtId'] as num).toInt(),
        amount: (json['amount'] as num).toDouble(),
        currency: json['currency'] as String? ?? 'PEN',
        status: json['status'] as String? ?? '',
        paymentDate: json['paymentDate'] as String?,
        declineReason: json['declineReason'] as String?,
        declineMessage: json['declineMessage'] as String?,
      );

  final int id;
  final int debtId;
  final double amount;
  final String currency;

  /// CONFIRMED, REJECTED, REGISTERED o PENDING_VERIFICATION.
  final String status;
  final String? paymentDate;
  final String? declineReason;
  final String? declineMessage;

  bool get isConfirmed => status.toUpperCase() == 'CONFIRMED';
  bool get isRejected => status.toUpperCase() == 'REJECTED';
}
