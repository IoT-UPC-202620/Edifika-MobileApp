import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../domain/payment_models.dart';
import '../domain/payments_repository.dart';

class PaymentsRepositoryImpl implements PaymentsRepository {
  PaymentsRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Debt>> getDebtsByUnit(int unitId) => guardApiCall(() async {
        final response = await _dio.get<Object>('${ApiEndpoints.debts}/unit/$unitId');
        return parseList(response.data, Debt.fromJson);
      });

  @override
  Future<List<Payment>> getPaymentsByUser(int userId) => guardApiCall(() async {
        final response = await _dio.get<Object>('${ApiEndpoints.payments}/user/$userId');
        return parseList(response.data, Payment.fromJson);
      });
}
