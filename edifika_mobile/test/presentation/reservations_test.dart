import 'package:edifika_mobile/core/network/api_exception.dart';
import 'package:edifika_mobile/features/reservations/domain/reservation_block.dart';
import 'package:edifika_mobile/features/reservations/presentation/new_reservation_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fakes.dart';

void main() {
  group('groupReservations', () {
    test('une horas consecutivas de la misma área y fecha en un bloque', () {
      final blocks = groupReservations([
        reservation(id: 3, slot: 17),
        reservation(id: 2, slot: 16),
        reservation(id: 4, slot: 19), // no consecutiva
        reservation(id: 5, slot: 18, status: 'CANCELLED'),
      ]);

      expect(blocks.map((b) => (b.fromHour, b.toHour, b.status)).toList(), [
        (16, 18, 'ACTIVE'),
        (18, 19, 'CANCELLED'),
        (19, 20, 'ACTIVE'),
      ]);
      expect(blocks.first.ids, [2, 3]);
    });
  });

  group('NewReservationCubit', () {
    late MockReservationsRepository repository;
    final now = DateTime(2026, 10, 15, 9);

    NewReservationCubit build({List existing = const []}) => NewReservationCubit(
          repository,
          areas: const [pool],
          reservations: existing.cast(),
          residentId: 2,
          now: () => now,
        );

    void stubCreate() {
      when(() => repository.createReservation(
            residentId: any(named: 'residentId'),
            commonAreaId: any(named: 'commonAreaId'),
            reservationDate: any(named: 'reservationDate'),
            timeSlot: any(named: 'timeSlot'),
            numberOfGuests: any(named: 'numberOfGuests'),
          )).thenAnswer((inv) async => reservation(
            id: 100 + (inv.namedArguments[#timeSlot] as int),
            slot: inv.namedArguments[#timeSlot] as int,
            date: inv.namedArguments[#reservationDate] as String,
          ));
    }

    setUp(() => repository = MockReservationsRepository());

    test('arranca mañana con la primera área disponible', () {
      final cubit = build();
      expect(cubit.state.areaId, pool.id);
      expect(cubit.state.apiDate, '2026-10-16');
    });

    test('detecta conflictos con horas ya reservadas antes de enviar', () async {
      final cubit = build(existing: [reservation(id: 9, slot: 11, date: '2026-10-16')])
        ..selectFrom(10)
        ..selectTo(12)
        ..acceptRules(true);

      expect(cubit.state.conflictingHours, [11]);
      await cubit.submit();

      expect(cubit.state.error, contains('Horario ocupado'));
      verifyNever(() => repository.createReservation(
            residentId: any(named: 'residentId'),
            commonAreaId: any(named: 'commonAreaId'),
            reservationDate: any(named: 'reservationDate'),
            timeSlot: any(named: 'timeSlot'),
            numberOfGuests: any(named: 'numberOfGuests'),
          ));
    });

    test('valida máximo de horas y de asistentes', () {
      final cubit = build()
        ..selectFrom(8)
        ..selectTo(12);
      expect(cubit.state.validationError(now), contains('hasta 3 horas'));

      cubit
        ..selectTo(9)
        ..setGuests(11);
      expect(cubit.state.validationError(now), contains('Máximo 10'));
    });

    test('exige aceptar las reglas', () async {
      final cubit = build();
      await cubit.submit();
      expect(cubit.state.error, contains('aceptar las reglas'));
    });

    test('un rango de 2 horas crea una reserva por hora', () async {
      stubCreate();
      final cubit = build()
        ..selectFrom(16)
        ..selectTo(18)
        ..setGuests(4)
        ..acceptRules(true);

      await cubit.submit();

      expect(cubit.state.created?.fromHour, 16);
      expect(cubit.state.created?.toHour, 18);
      verify(() => repository.createReservation(
            residentId: 2,
            commonAreaId: 1,
            reservationDate: '2026-10-16',
            timeSlot: any(named: 'timeSlot'),
            numberOfGuests: 4,
          )).called(2);
    });

    test('si una hora falla (409) cancela las ya creadas', () async {
      when(() => repository.createReservation(
            residentId: any(named: 'residentId'),
            commonAreaId: any(named: 'commonAreaId'),
            reservationDate: any(named: 'reservationDate'),
            timeSlot: 16,
            numberOfGuests: any(named: 'numberOfGuests'),
          )).thenAnswer((_) async => reservation(id: 116, slot: 16, date: '2026-10-16'));
      when(() => repository.createReservation(
            residentId: any(named: 'residentId'),
            commonAreaId: any(named: 'commonAreaId'),
            reservationDate: any(named: 'reservationDate'),
            timeSlot: 17,
            numberOfGuests: any(named: 'numberOfGuests'),
          )).thenThrow(const ApiException(ApiErrorKind.conflict, 'Este horario ya se encuentra reservado, elija otro', statusCode: 409));
      when(() => repository.cancelReservation(116))
          .thenAnswer((_) async => reservation(id: 116, slot: 16, status: 'CANCELLED'));
      when(() => repository.getReservations()).thenAnswer((_) async => []);

      final cubit = build()
        ..selectFrom(16)
        ..selectTo(18)
        ..acceptRules(true);
      await cubit.submit();

      expect(cubit.state.created, isNull);
      expect(cubit.state.error, 'Este horario ya se encuentra reservado, elija otro');
      verify(() => repository.cancelReservation(116)).called(1);
    });
  });
}
