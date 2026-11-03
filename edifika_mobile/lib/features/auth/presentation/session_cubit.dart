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

  Future<void> loadResidence() async {
    final user = state.user;
    if (user == null) return;
    final buildingId = user.buildingId;
    if (buildingId == null) {
      emit(state.copyWith(residenceError: 'Tu usuario no tiene un edificio asignado. Contacta a tu administración.'));
      return;
    }

    emit(state.copyWith(loadingResidence: true, residenceError: null));
    try {
      final building = await _residential.getBuilding(buildingId);
      final relation = await _residential.getActiveUserUnit(buildingId: buildingId, userId: user.id);
      final unit = relation == null ? null : await _residential.getUnit(relation.idUnit);
      emit(state.copyWith(loadingResidence: false, residence: Residence(building: building, unit: unit)));
    } on ApiException catch (error) {
      emit(state.copyWith(loadingResidence: false, residenceError: error.message));
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
