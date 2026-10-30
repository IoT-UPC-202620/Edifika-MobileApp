import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/utils/formatters.dart';
import '../domain/reservation_block.dart';
import '../domain/reservation_models.dart';
import '../domain/reservations_repository.dart';

part 'new_reservation_cubit.freezed.dart';

/// Horario reservable mostrado en los selectores (Figma: gimnasio 06:00–22:00).
const firstBookableHour = 6;
const lastBookableHour = 22;

@freezed
abstract class NewReservationState with _$NewReservationState {
  const factory NewReservationState({
    required List<CommonArea> areas,
    required List<Reservation> reservations,
    int? areaId,
    required DateTime date,
    @Default(10) int fromHour,
    @Default(11) int toHour,
    @Default(1) int guests,
    @Default(false) bool acceptedRules,
    @Default(false) bool submitting,
    String? error,
    ReservationBlock? created,
  }) = _NewReservationState;

  const NewReservationState._();

  CommonArea? get area => areas.where((a) => a.id == areaId).firstOrNull;

  String get apiDate => Formatters.apiDate(date);

  /// Horas del rango elegido: [fromHour, toHour).
  List<int> get hours => [for (var h = fromHour; h < toHour; h++) h];

  Set<int> get takenHours =>
      areaId == null ? const {} : takenTimeSlots(reservations, commonAreaId: areaId!, date: apiDate);

  List<int> get conflictingHours => hours.where(takenHours.contains).toList();

  /// Motivo por el que no se puede reservar, o `null` si el horario es válido.
  /// Se valida en la UI antes de enviar (la fake API igual responde 409).
  String? validationError(DateTime now) {
    final selected = area;
    if (selected == null) return 'Elige un área común.';
    if (!selected.isAvailable) return '${selected.name} está en mantenimiento.';
    if (toHour <= fromHour) return 'La hora de fin debe ser posterior a la de inicio.';
    final start = DateTime(date.year, date.month, date.day, fromHour);
    if (start.isBefore(now)) return 'Elige un horario futuro.';
    final maxHours = selected.rules?.maxReservationHours ?? 0;
    if (maxHours > 0 && hours.length > maxHours) {
      return 'Puedes reservar hasta $maxHours ${maxHours == 1 ? 'hora' : 'horas'} seguidas.';
    }
    if (selected.maxCapacity > 0 && guests > selected.maxCapacity) {
      return 'Máximo ${selected.maxCapacity} asistentes por reserva.';
    }
    if (guests < 1) return 'Indica al menos 1 asistente.';
    if (conflictingHours.isNotEmpty) {
      return 'Horario ocupado: ${conflictingHours.map((h) => Formatters.hourRange(h, h + 1)).join(', ')}.';
    }
    return null;
  }
}

/// Mockup 06 · Nueva reserva.
class NewReservationCubit extends Cubit<NewReservationState> {
  NewReservationCubit(
    this._repository, {
    required List<CommonArea> areas,
    required List<Reservation> reservations,
    required this.residentId,
    DateTime Function()? now,
  })  : _now = now ?? DateTime.now,
        super(NewReservationState(
          areas: areas,
          reservations: reservations,
          areaId: areas.where((a) => a.isAvailable).firstOrNull?.id,
          date: _tomorrow((now ?? DateTime.now)()),
        ));

  final ReservationsRepository _repository;
  final int residentId;
  final DateTime Function() _now;

  static DateTime _tomorrow(DateTime now) => DateTime(now.year, now.month, now.day + 1);

  void selectArea(int? id) => emit(state.copyWith(areaId: id, error: null));
  void selectDate(DateTime date) => emit(state.copyWith(date: date, error: null));

  void selectFrom(int hour) {
    // Mantiene la duración elegida al mover la hora de inicio.
    final duration = (state.toHour - state.fromHour).clamp(1, 24);
    emit(state.copyWith(fromHour: hour, toHour: (hour + duration).clamp(hour + 1, lastBookableHour + 1), error: null));
  }

  void selectTo(int hour) => emit(state.copyWith(toHour: hour, error: null));
  void setGuests(int guests) => emit(state.copyWith(guests: guests, error: null));
  void acceptRules(bool value) => emit(state.copyWith(acceptedRules: value));

  Future<void> submit() async {
    final invalid = state.validationError(_now());
    if (invalid != null) {
      emit(state.copyWith(error: invalid));
      return;
    }
    if (!state.acceptedRules) {
      emit(state.copyWith(error: 'Debes aceptar las reglas del área común.'));
      return;
    }

    emit(state.copyWith(submitting: true, error: null));
    final created = <Reservation>[];
    try {
      for (final hour in state.hours) {
        created.add(await _repository.createReservation(
          residentId: residentId,
          commonAreaId: state.areaId!,
          reservationDate: state.apiDate,
          timeSlot: hour,
          numberOfGuests: state.guests,
        ));
      }
      emit(state.copyWith(submitting: false, created: ReservationBlock(created)));
    } on ApiException catch (error) {
      // No dejar un rango reservado a medias.
      for (final r in created) {
        try {
          await _repository.cancelReservation(r.id);
        } on ApiException {
          // Si la reversión falla, el residente verá esa hora en "Mis reservas".
        }
      }
      final refreshed = await _safeReservations();
      emit(state.copyWith(submitting: false, error: error.message, reservations: refreshed ?? state.reservations));
    }
  }

  Future<List<Reservation>?> _safeReservations() async {
    try {
      return await _repository.getReservations();
    } on ApiException {
      return null;
    }
  }
}
