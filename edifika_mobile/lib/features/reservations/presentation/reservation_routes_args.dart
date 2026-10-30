import '../domain/reservation_block.dart';
import '../domain/reservation_models.dart';

/// Datos que recibe "Nueva reserva" (evita volver a pedirlos a la API).
class NewReservationArgs {
  const NewReservationArgs({required this.areas, required this.reservations, this.initialAreaId});

  final List<CommonArea> areas;
  final List<Reservation> reservations;
  final int? initialAreaId;
}

/// Datos de "Reserva confirmada" / detalle de una reserva.
class ReservationDetailArgs {
  const ReservationDetailArgs({required this.block, required this.areaName, this.area, this.justCreated = false});

  final ReservationBlock block;
  final String areaName;
  final CommonArea? area;
  final bool justCreated;
}
