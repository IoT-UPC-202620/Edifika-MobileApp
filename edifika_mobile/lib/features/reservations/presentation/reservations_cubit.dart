import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/events/reload_on_data_changes.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/utils/load_status.dart';
import '../domain/reservation_block.dart';
import '../domain/reservation_models.dart';
import '../domain/reservations_repository.dart';

part 'reservations_cubit.freezed.dart';

@freezed
abstract class ReservationsState with _$ReservationsState {
  const factory ReservationsState({
    @Default(LoadStatus.loading) LoadStatus status,
    String? error,
    @Default(<CommonArea>[]) List<CommonArea> areas,

    /// Todas las reservas del edificio (para calcular disponibilidad).
    @Default(<Reservation>[]) List<Reservation> allReservations,
    @Default(<ReservationBlock>[]) List<ReservationBlock> upcoming,
    @Default(<ReservationBlock>[]) List<ReservationBlock> past,
  }) = _ReservationsState;

  const ReservationsState._();

  String areaName(int id) => areas.where((a) => a.id == id).firstOrNull?.name ?? 'Área común';
}

/// Mockup 05 · Reservas.
class ReservationsCubit extends Cubit<ReservationsState> with ReloadOnDataChanges<ReservationsState> {
  ReservationsCubit(this._repository, {Stream<void>? dataChanges, DateTime Function()? now})
      : _now = now ?? DateTime.now,
        super(const ReservationsState()) {
    listenDataChanges(dataChanges, () {
      final userId = _userId;
      if (userId != null) load(userId, silent: true);
    });
  }

  final ReservationsRepository _repository;
  final DateTime Function() _now;
  int? _userId;

  /// Con `silent: true` mantiene el contenido actual mientras recarga.
  Future<void> load(int userId, {bool silent = false}) async {
    _userId = userId;
    if (!silent || state.status != LoadStatus.ready) {
      emit(state.copyWith(status: LoadStatus.loading, error: null));
    }
    try {
      final areasFuture = _repository.getCommonAreas();
      final reservationsFuture = _repository.getReservations();
      await Future.wait([areasFuture, reservationsFuture]);
      final all = await reservationsFuture;
      final mine = groupReservations(all.where((r) => r.residentId == userId));
      final now = _now();
      emit(state.copyWith(
        status: LoadStatus.ready,
        areas: await areasFuture,
        allReservations: all,
        upcoming: mine.where((b) => b.isUpcoming(now)).toList(),
        past: mine.where((b) => !b.isUpcoming(now)).toList().reversed.toList(),
      ));
    } on ApiException catch (error) {
      emit(state.copyWith(status: LoadStatus.failure, error: error.message));
    }
  }
}
