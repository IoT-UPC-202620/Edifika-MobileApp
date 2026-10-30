import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/utils/load_status.dart';
import '../domain/payment_models.dart';
import '../domain/payments_repository.dart';

part 'account_cubits.freezed.dart';

const _noUnitMessage = 'No tienes un departamento asignado. Contacta a tu administración.';

@freezed
abstract class DebtsState with _$DebtsState {
  const factory DebtsState({
    @Default(LoadStatus.loading) LoadStatus status,
    String? error,

    /// Solo deudas pendientes, de la que vence primero a la última.
    @Default(<Debt>[]) List<Debt> debts,
  }) = _DebtsState;

  const DebtsState._();

  double get total => debts.fold(0, (sum, d) => sum + d.amount);
  String get currency => debts.isEmpty ? 'PEN' : debts.first.currency;
}

/// Mockup 03 · Mis deudas (solo las del departamento del residente).
class DebtsCubit extends Cubit<DebtsState> {
  DebtsCubit(this._payments) : super(const DebtsState());

  final PaymentsRepository _payments;

  Future<void> load(int? unitId) async {
    if (unitId == null) {
      emit(const DebtsState(status: LoadStatus.failure, error: _noUnitMessage));
      return;
    }
    emit(state.copyWith(status: LoadStatus.loading, error: null));
    try {
      final debts = (await _payments.getDebtsByUnit(unitId)).where((d) => d.isPending).toList()
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
      emit(DebtsState(status: LoadStatus.ready, debts: debts));
    } on ApiException catch (error) {
      emit(state.copyWith(status: LoadStatus.failure, error: error.message));
    }
  }
}

@freezed
abstract class PaymentsState with _$PaymentsState {
  const factory PaymentsState({
    @Default(LoadStatus.loading) LoadStatus status,
    String? error,

    /// Todos los pagos del residente, del más reciente al más antiguo.
    @Default(<Payment>[]) List<Payment> payments,

    /// Concepto de cada deuda pagada (el pago solo trae `debtId`).
    @Default(<int, String>{}) Map<int, String> conceptByDebtId,
    int? year,
  }) = _PaymentsState;

  const PaymentsState._();

  List<int> get years {
    final set = {for (final p in payments) DateTime.tryParse(p.paymentDate)?.year}..remove(null);
    return set.cast<int>().toList()..sort((a, b) => b.compareTo(a));
  }

  List<Payment> get visible =>
      year == null ? payments : payments.where((p) => DateTime.tryParse(p.paymentDate)?.year == year).toList();

  Payment? get lastConfirmed => payments.where((p) => p.status.toUpperCase() == 'PAID').firstOrNull;

  String conceptOf(Payment payment) => conceptByDebtId[payment.debtId] ?? 'Pago de deuda #${payment.debtId}';
}

/// Mockup 04 · Mis pagos.
class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit(this._payments) : super(const PaymentsState());

  final PaymentsRepository _payments;

  Future<void> load({required int userId, int? unitId}) async {
    emit(state.copyWith(status: LoadStatus.loading, error: null));
    try {
      final paymentsFuture = _payments.getPaymentsByUser(userId);
      final debtsFuture = unitId == null ? Future.value(<Debt>[]) : _payments.getDebtsByUnit(unitId);
      await Future.wait([paymentsFuture, debtsFuture]);
      final payments = (await paymentsFuture)..sort((a, b) => b.paymentDate.compareTo(a.paymentDate));
      final concepts = {for (final d in await debtsFuture) d.id: d.description};
      final years = PaymentsState(payments: payments).years;
      emit(PaymentsState(
        status: LoadStatus.ready,
        payments: payments,
        conceptByDebtId: concepts,
        year: years.isEmpty ? null : years.first,
      ));
    } on ApiException catch (error) {
      emit(state.copyWith(status: LoadStatus.failure, error: error.message));
    }
  }

  void selectYear(int? year) => emit(state.copyWith(year: year));
}
