import 'payment_models.dart';

abstract class PaymentsRepository {
  Future<List<Debt>> getDebtsByUnit(int unitId);

  Future<List<Payment>> getPaymentsByUser(int userId);
}
