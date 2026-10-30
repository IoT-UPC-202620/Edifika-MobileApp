import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/events/reload_on_data_changes.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/utils/load_status.dart';
import '../../announcements/domain/announcement.dart';
import '../../announcements/domain/announcements_repository.dart';
import '../../notifications/domain/notifications_repository.dart';
import '../../payments/domain/payment_models.dart';
import '../../payments/domain/payments_repository.dart';
import '../../reservations/domain/reservation_block.dart';
import '../../reservations/domain/reservations_repository.dart';

part 'home_cubit.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(LoadStatus.loading) LoadStatus status,
    String? error,
    @Default(0) double pendingTotal,
    @Default(0) double overdueTotal,
    @Default('PEN') String currency,
    ReservationBlock? nextReservation,
    String? nextReservationArea,
    @Default(0) int unreadNotifications,
    Announcement? latestAnnouncement,

    /// La fake API no tiene comunicados: el bloque se muestra como pendiente.
    @Default(false) bool announcementsUnavailable,
  }) = _HomeState;

  const HomeState._();

  double get debtTotal => pendingTotal + overdueTotal;
}

/// Resumen de Inicio: deuda, próxima reserva, notificaciones y último anuncio.
class HomeCubit extends Cubit<HomeState> with ReloadOnDataChanges<HomeState> {
  HomeCubit({
    required PaymentsRepository payments,
    required ReservationsRepository reservations,
    required NotificationsRepository notifications,
    required AnnouncementsRepository announcements,
    Stream<void>? dataChanges,
    DateTime Function()? now,
  })  : _payments = payments,
        _reservations = reservations,
        _notifications = notifications,
        _announcements = announcements,
        _now = now ?? DateTime.now,
        super(const HomeState()) {
    listenDataChanges(dataChanges, () {
      final args = _lastArgs;
      if (args != null) load(userId: args.userId, buildingId: args.buildingId, unitId: args.unitId, silent: true);
    });
  }

  final PaymentsRepository _payments;
  final ReservationsRepository _reservations;
  final NotificationsRepository _notifications;
  final AnnouncementsRepository _announcements;
  final DateTime Function() _now;
  ({int userId, int buildingId, int? unitId})? _lastArgs;

  /// Con `silent: true` mantiene el contenido actual mientras recarga.
  Future<void> load({required int userId, required int buildingId, int? unitId, bool silent = false}) async {
    _lastArgs = (userId: userId, buildingId: buildingId, unitId: unitId);
    if (!silent || state.status != LoadStatus.ready) {
      emit(state.copyWith(status: LoadStatus.loading, error: null));
    }
    final now = _now();
    try {
      // Se lanzan en paralelo y se esperan por separado para conservar los tipos.
      final debtsFuture = unitId == null ? Future.value(<Debt>[]) : _payments.getDebtsByUnit(unitId);
      final reservationsFuture = _reservations.getReservations();
      final areasFuture = _reservations.getCommonAreas();
      final notificationsFuture = _notifications.getByUser(userId);
      // Future.wait observa los errores de todas; luego cada await ya resolvió.
      await Future.wait([debtsFuture, reservationsFuture, areasFuture, notificationsFuture]);
      final pendingDebts = (await debtsFuture).where((d) => d.isPending).toList();
      var overdue = 0.0;
      var pending = 0.0;
      for (final debt in pendingDebts) {
        if (debt.isOverdue(now)) {
          overdue += debt.amount;
        } else {
          pending += debt.amount;
        }
      }

      final upcoming = groupReservations(await reservationsFuture)
          .where((b) => b.first.residentId == userId && b.isUpcoming(now))
          .toList();
      final next = upcoming.isEmpty ? null : upcoming.first;
      final areas = await areasFuture;
      final areaName = next == null ? null : areas.where((a) => a.id == next.commonAreaId).firstOrNull?.name;

      final unread = (await notificationsFuture).where((n) => !n.read).length;

      emit(state.copyWith(
        status: LoadStatus.ready,
        pendingTotal: pending,
        overdueTotal: overdue,
        currency: pendingDebts.isEmpty ? 'PEN' : pendingDebts.first.currency,
        nextReservation: next,
        nextReservationArea: areaName,
        unreadNotifications: unread,
      ));
    } on ApiException catch (error) {
      emit(state.copyWith(status: LoadStatus.failure, error: error.message));
      return;
    }

    try {
      final list = await _announcements.getByBuilding(buildingId);
      emit(state.copyWith(latestAnnouncement: list.isEmpty ? null : list.last, announcementsUnavailable: false));
    } on ApiException {
      emit(state.copyWith(announcementsUnavailable: true));
    }
  }
}
