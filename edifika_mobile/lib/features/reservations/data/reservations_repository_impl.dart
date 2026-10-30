import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/events/data_changes.dart';
import '../../../core/network/api_client.dart';
import '../domain/reservation_models.dart';
import '../domain/reservations_repository.dart';

class ReservationsRepositoryImpl implements ReservationsRepository {
  ReservationsRepositoryImpl(this._dio, [this._changes]);

  final Dio _dio;
  final DataChanges? _changes;

  @override
  Future<List<CommonArea>> getCommonAreas() => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.commonAreas);
        return parseList(response.data, CommonArea.fromJson);
      });

  @override
  Future<List<Reservation>> getReservations() => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.reservations);
        return parseList(response.data, Reservation.fromJson);
      });

  @override
  Future<Reservation> createReservation({
    required int residentId,
    required int commonAreaId,
    required String reservationDate,
    required int timeSlot,
    int numberOfGuests = 1,
  }) =>
      guardApiCall(() async {
        final response = await _dio.post<Map<String, dynamic>>(
          ApiEndpoints.reservations,
          data: {
            'residentId': residentId,
            'commonAreaId': commonAreaId,
            'reservationDate': reservationDate,
            'timeSlot': timeSlot,
            'numberOfGuests': numberOfGuests,
          },
        );
        _changes?.notify();
        return Reservation.fromJson(response.data!);
      });

  @override
  Future<Reservation> cancelReservation(int reservationId) => guardApiCall(() async {
        final response = await _dio.post<Map<String, dynamic>>(
          '${ApiEndpoints.reservations}/$reservationId/cancelations',
          data: const <String, dynamic>{},
        );
        _changes?.notify();
        return Reservation.fromJson(response.data!);
      });
}
