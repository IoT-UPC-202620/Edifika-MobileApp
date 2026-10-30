import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_models.freezed.dart';
part 'reservation_models.g.dart';

@freezed
abstract class CommonAreaRule with _$CommonAreaRule {
  const factory CommonAreaRule({
    @Default(0) int maxReservationHours,
    @Default(false) bool requiresPayment,
    @Default(0) double price,
    @Default(false) bool requiresGuarantee,
    @Default(0) double guaranteeAmount,
    @Default(true) bool allowCancellation,
    @Default(0) int penaltyHoursBefore,
    @Default(0) double penaltyAmount,
    @Default(false) bool requiresApproval,
  }) = _CommonAreaRule;

  factory CommonAreaRule.fromJson(Map<String, dynamic> json) => _$CommonAreaRuleFromJson(json);
}

@freezed
abstract class CommonArea with _$CommonArea {
  const CommonArea._();

  const factory CommonArea({
    required int id,
    required String name,
    required String type,
    required String status,
    @Default(0) int maxCapacity,
    @Default('SHARED') String bookingType,
    CommonAreaRule? rules,
  }) = _CommonArea;

  factory CommonArea.fromJson(Map<String, dynamic> json) => _$CommonAreaFromJson(json);

  bool get isAvailable => status.toUpperCase() == 'AVAILABLE';
}

@freezed
abstract class Reservation with _$Reservation {
  const Reservation._();

  const factory Reservation({
    required int id,
    required int residentId,
    required int commonAreaId,

    /// `yyyy-MM-dd`
    required String reservationDate,

    /// Hora de inicio (0-23).
    required int timeSlot,
    @Default(1) int numberOfGuests,
    required String status,
    @Default('') String qrCodeAccess,
    @Default(false) bool penaltyApplied,
  }) = _Reservation;

  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

  bool get isActive => status.toUpperCase() == 'ACTIVE';
}

/// Horas ya ocupadas de un área en una fecha. Replica la regla de duplicados
/// de `POST /reservations` en la fake API (misma área, fecha y hora, ACTIVE),
/// para que la UI marque conflictos antes de enviar.
Set<int> takenTimeSlots(Iterable<Reservation> reservations, {required int commonAreaId, required String date}) => {
      for (final r in reservations)
        if (r.isActive && r.commonAreaId == commonAreaId && r.reservationDate == date) r.timeSlot,
    };
