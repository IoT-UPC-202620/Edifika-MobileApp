import 'reservation_models.dart';

/// Varias reservas de una hora, consecutivas, de la misma área, fecha y
/// residente, mostradas como un solo bloque ("16:00–18:00").
///
/// La fake API reserva por `timeSlot` (1 hora); el diseño reserva por rango.
class ReservationBlock {
  const ReservationBlock(this.reservations);

  /// Ordenadas por hora, no vacía.
  final List<Reservation> reservations;

  Reservation get first => reservations.first;
  int get commonAreaId => first.commonAreaId;
  String get date => first.reservationDate;
  int get fromHour => first.timeSlot;
  int get toHour => reservations.last.timeSlot + 1;
  String get status => first.status.toUpperCase();
  int get guests => first.numberOfGuests;
  List<int> get ids => [for (final r in reservations) r.id];

  /// Código legible para el residente, p. ej. `R-20261017-12`.
  String get code => 'R-${date.replaceAll('-', '')}-${first.id}';

  DateTime get start {
    final day = DateTime.parse(date);
    return DateTime(day.year, day.month, day.day, fromHour);
  }

  bool isUpcoming(DateTime now) => status == 'ACTIVE' && !start.add(Duration(hours: toHour - fromHour)).isBefore(now);
}

List<ReservationBlock> groupReservations(Iterable<Reservation> reservations) {
  final sorted = reservations.toList()
    ..sort((a, b) {
      final byKey = '${a.residentId}|${a.commonAreaId}|${a.reservationDate}|${a.status}'
          .compareTo('${b.residentId}|${b.commonAreaId}|${b.reservationDate}|${b.status}');
      return byKey != 0 ? byKey : a.timeSlot.compareTo(b.timeSlot);
    });

  final blocks = <List<Reservation>>[];
  for (final r in sorted) {
    final current = blocks.isEmpty ? null : blocks.last;
    final last = current?.last;
    final continues = last != null &&
        last.residentId == r.residentId &&
        last.commonAreaId == r.commonAreaId &&
        last.reservationDate == r.reservationDate &&
        last.status.toUpperCase() == r.status.toUpperCase() &&
        last.timeSlot + 1 == r.timeSlot;
    if (continues) {
      current!.add(r);
    } else {
      blocks.add([r]);
    }
  }
  return [for (final b in blocks) ReservationBlock(b)]..sort((a, b) => a.start.compareTo(b.start));
}
