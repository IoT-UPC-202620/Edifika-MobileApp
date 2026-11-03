import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/utils/load_status.dart';
import '../../profile/domain/profile_repository.dart';
import '../../profile/domain/user_profile.dart';
import '../domain/iot_models.dart';
import '../domain/iot_repository.dart';
import 'iot_labels.dart';

part 'iot_cards_cubit.freezed.dart';

/// Filtro de la lista de tarjetas.
enum CardFilter { all, active, inactive }

@freezed
abstract class IotCardsState with _$IotCardsState {
  const factory IotCardsState({
    @Default(LoadStatus.loading) LoadStatus status,
    String? error,
    @Default(<AccessCredential>[]) List<AccessCredential> credentials,

    /// Usuarios del IAM por id, para mostrar email y rol del titular.
    @Default(<int, UserProfile>{}) Map<int, UserProfile> users,
    @Default(CardFilter.all) CardFilter filter,

    /// Tarjeta con un cambio de estado en curso.
    int? busyCredentialId,

    /// Aviso puntual para un SnackBar.
    String? message,
  }) = _IotCardsState;

  const IotCardsState._();

  int get activeCount => credentials.where((c) => c.status.toUpperCase() == 'ACTIVE').length;

  /// Tarjetas filtradas: primero las activas, luego por titular.
  List<AccessCredential> get visible {
    final list = credentials.where((c) {
      final active = c.status.toUpperCase() == 'ACTIVE';
      return switch (filter) {
        CardFilter.all => true,
        CardFilter.active => active,
        CardFilter.inactive => !active,
      };
    }).toList()
      ..sort((a, b) {
        final byStatus = _rank(a.status).compareTo(_rank(b.status));
        if (byStatus != 0) return byStatus;
        return holderOf(a).toLowerCase().compareTo(holderOf(b).toLowerCase());
      });
    return list;
  }

  UserProfile? userOf(AccessCredential c) => c.userId == null ? null : users[c.userId];

  String holderOf(AccessCredential c) {
    final name = c.holderName;
    if (name != null && name.isNotEmpty) return name;
    return userOf(c)?.fullName ?? 'Sin titular';
  }

  static int _rank(String status) => switch (status.toUpperCase()) {
        'ACTIVE' => 0,
        'SUSPENDED' => 1,
        _ => 2,
      };
}

/// Tarjetas RFID de un edificio: el administrador las ve con su titular y las
/// suspende, reactiva, marca perdidas o revoca. El registro de una tarjeta nueva
/// se hace en el lector (detalle del dispositivo, modo registro).
class IotCardsCubit extends Cubit<IotCardsState> {
  IotCardsCubit(this._iot, {required this.buildingId, ProfileRepository? profile})
      : _profile = profile,
        super(const IotCardsState());

  final IotRepository _iot;
  final ProfileRepository? _profile;
  final int buildingId;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading, error: null));
    await _fetch();
  }

  /// Recarga sin spinner (al volver del registro en el lector, o pull to refresh).
  Future<void> refresh() => _fetch();

  Future<void> _fetch() async {
    try {
      final credentialsCall = _iot.getCredentials(buildingId);
      final usersCall = _loadUsers();
      final credentials = await credentialsCall;
      final users = await usersCall;
      if (isClosed) return;
      emit(state.copyWith(
        status: LoadStatus.ready,
        credentials: credentials,
        users: users ?? state.users,
        error: null,
      ));
    } on ApiException catch (error) {
      if (isClosed) return;
      if (state.status == LoadStatus.ready) {
        emit(state.copyWith(message: error.message));
      } else {
        emit(state.copyWith(status: LoadStatus.failure, error: error.message));
      }
    }
  }

  /// Los usuarios solo enriquecen la lista: si el IAM falla se muestra el titular guardado.
  Future<Map<int, UserProfile>?> _loadUsers() async {
    final profile = _profile;
    if (profile == null) return null;
    try {
      final users = await profile.getUsers();
      return {for (final u in users) u.id: u};
    } on ApiException {
      return null;
    }
  }

  void setFilter(CardFilter filter) => emit(state.copyWith(filter: filter));

  /// Cambia el estado de una tarjeta (`ACTIVE`, `SUSPENDED`, `LOST`, `REVOKED`).
  Future<void> changeStatus(AccessCredential credential, String status) async {
    if (state.busyCredentialId != null) return;
    emit(state.copyWith(busyCredentialId: credential.id, message: null));
    try {
      final updated = await _iot.changeCredentialStatus(credential.id, status);
      if (isClosed) return;
      final (label, _) = IotLabels.credentialStatus(updated.status);
      emit(state.copyWith(
        busyCredentialId: null,
        credentials: [for (final c in state.credentials) c.id == updated.id ? updated : c],
        message: 'Tarjeta ${updated.rfidUid}: ${label.toLowerCase()}.',
      ));
    } on ApiException catch (error) {
      if (isClosed) return;
      emit(state.copyWith(busyCredentialId: null, message: error.message));
    }
  }
}
