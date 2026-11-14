import 'payment_models.dart';
import 'payment_result.dart';

abstract class PaymentsRepository {
  Future<List<Debt>> getDebtsByUnit(int unitId);

  Future<List<Payment>> getPaymentsByUser(int userId);

  /// `POST /payments` con `{debtId, paymentMethod: CULQI, culqiToken}` y header `Idempotency-Key`.
  /// El backend cobra el monto de la deuda (el cliente no envia monto). Un rechazo de tarjeta
  /// llega como 201 con status REJECTED; repetir la misma clave devuelve el mismo pago.
  Future<PaymentResult> payDebt({required int debtId, required String culqiToken, required String idempotencyKey});
}
