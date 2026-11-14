import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../residential/domain/residence.dart';
import '../../residential/domain/residential_repository.dart';
import '../domain/auth_repository.dart';
import '../domain/authenticated_user.dart';

part 'session_cubit.freezed.dart';

enum SessionStatus { unknown, unauthenticated, authenticated }

@freezed
abstract class SessionState with _$SessionState {
  const factory SessionState({
    @Default(SessionStatus.unknown) SessionStatus status,
    AuthenticatedUser? user,
    Residence? residence,
    @Default(false) bool loadingResidence,
    String? residenceError,

    /// Mensaje a mostrar en el login (p. ej. "tu sesión expiró").
    String? notice,
  }) = _SessionState;
}

/// Estado de sesión de toda la app (lo usa go_router para redirigir).
class SessionCubit extends Cubit<SessionState> {
  SessionCubit({
    required AuthRepository auth,
    required ResidentialRepository residential,
    required Stream<void> sessionExpired,
  })  : _auth = auth,
        _residential = residential,
        super(const SessionState()) {
    _expiredSub = sessionExpired.listen((_) {
      emit(const SessionState(status: SessionStatus.unauthenticated, notice: 'Tu sesión expiró. Inicia sesión nuevamente.'));
    });
  }

  final AuthRepository _auth;
  final ResidentialRepository _residential;
  late final StreamSubscription<void> _expiredSub;

  /// Al abrir la app: un token vencido o ilegible ya lo descarta `restoreSession`;
  /// uno con firma invalida lo detecta el 401 de /residents/me (o el interceptor).
  Future<void> restore() async {
    final user = await _auth.restoreSession();
    if (user == null || !user.canUseMobileApp) {
      emit(const SessionState(status: SessionStatus.unauthenticated));
      return;
    }
    await signedIn(user);
  }

  Future<void> signedIn(AuthenticatedUser user) async {
    emit(SessionState(status: SessionStatus.authenticated, user: user));
    // El administrador no vive en una unidad: elige el edificio en la gestión IoT.
    if (user.isAdmin) return;
    await loadResidence();
  }

  /// Edificio y unidad del residente desde `GET /residential/residents/me` (userId del JWT).
  Future<void> loadResidence() async {
    final user = state.user;
    if (user == null) return;

    emit(state.copyWith(loadingResidence: true, residenceError: null));
    try {
      final me = await _residential.getMyResidence();
      final building = await _residential.getBuilding(me.buildingId);
      final unit = await _residential.getUnit(me.unitId);
      emit(state.copyWith(
        loadingResidence: false,
        residence: Residence(building: building, unit: unit, relationType: me.relationType),
      ));
    } on ApiException catch (error) {
      if (error.statusCode == 401) {
        // Token invalido o revocado: se borra la sesion y se vuelve al login.
        await _auth.signOut();
        emit(const SessionState(status: SessionStatus.unauthenticated, notice: 'Tu sesión expiró. Inicia sesión nuevamente.'));
        return;
      }
      emit(state.copyWith(
        loadingResidence: false,
        residenceError: error.statusCode == 404
            ? 'Tu usuario no tiene un edificio asignado. Contacta a tu administración.'
            : error.message,
      ));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    emit(const SessionState(status: SessionStatus.unauthenticated));
  }

  @override
  Future<void> close() async {
    await _expiredSub.cancel();
    return super.close();
  }
}
