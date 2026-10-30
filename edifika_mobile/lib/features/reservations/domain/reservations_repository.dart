import 'reservation_models.dart';

abstract class ReservationsRepository {
  Future<List<CommonArea>> getCommonAreas();

  /// Todas las reservas (para calcular disponibilidad).
  Future<List<Reservation>> getReservations();

  /// Lanza `ApiException` con `ApiErrorKind.conflict` si el horario ya está tomado.
  Future<Reservation> createReservation({
    required int residentId,
    required int commonAreaId,
    required String reservationDate,
    required int timeSlot,
    int numberOfGuests = 1,
  });

  Future<Reservation> cancelReservation(int reservationId);
}
