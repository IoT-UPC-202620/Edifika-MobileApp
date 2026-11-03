import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/utils/load_status.dart';
import '../domain/iot_models.dart';
import '../domain/iot_repository.dart';

part 'iot_discovery_cubit.freezed.dart';

@freezed
abstract class IotDiscoveryState with _$IotDiscoveryState {
  const factory IotDiscoveryState({
    @Default(LoadStatus.loading) LoadStatus status,
    String? error,
    @Default(<DiscoveredDevice>[]) List<DiscoveredDevice> devices,

    /// Aviso puntual para un SnackBar.
    String? message,
  }) = _IotDiscoveryState;
}

/// Nodos que los gateways de un edificio identificaron y esperan ser adoptados.
class IotDiscoveryCubit extends Cubit<IotDiscoveryState> {
  IotDiscoveryCubit(this._iot, {required this.buildingId}) : super(const IotDiscoveryState());

  final IotRepository _iot;
  final int buildingId;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading, error: null));
    await refresh();
  }

  /// Recarga sin spinner (al volver de adoptar, o pull to refresh).
  Future<void> refresh() async {
    try {
      final devices = await _iot.getDiscoveredDevices(buildingId);
      if (isClosed) return;
      emit(state.copyWith(status: LoadStatus.ready, devices: devices, error: null));
    } on ApiException catch (error) {
      if (isClosed) return;
      if (state.status == LoadStatus.ready) {
        emit(state.copyWith(message: error.message));
      } else {
        emit(state.copyWith(status: LoadStatus.failure, error: error.message));
      }
    }
  }
}

/// Acción en curso en la pantalla de adopción.
enum AdoptAction { none, identifying, adopting, ignoring }

@freezed
abstract class IotAdoptState with _$IotAdoptState {
  const factory IotAdoptState({
    required DiscoveredDevice discovered,
    @Default(AdoptAction.none) AdoptAction action,

    /// Dispositivo creado al adoptar; la pantalla se cierra al recibirlo.
    IotDevice? adopted,
    @Default(false) bool ignored,
    String? error,

    /// Aviso puntual para un SnackBar.
    String? message,
  }) = _IotAdoptState;

  const IotAdoptState._();

  bool get busy => action != AdoptAction.none;
}

/// Identificar, adoptar o ignorar un nodo descubierto.
class IotAdoptCubit extends Cubit<IotAdoptState> {
  IotAdoptCubit(this._iot, {required DiscoveredDevice discovered}) : super(IotAdoptState(discovered: discovered));

  final IotRepository _iot;

  /// El nodo parpadea en blanco y suena para reconocer la placa.
  Future<void> identify() async {
    if (state.busy) return;
    emit(state.copyWith(action: AdoptAction.identifying, error: null, message: null));
    try {
      await _iot.identifyDiscoveredDevice(state.discovered.id);
      if (isClosed) return;
      emit(state.copyWith(action: AdoptAction.none, message: 'El dispositivo parpadea en blanco durante 10 segundos.'));
    } on ApiException catch (error) {
      if (isClosed) return;
      emit(state.copyWith(action: AdoptAction.none, error: error.message));
    }
  }

  Future<void> adopt({
    required String name,
    required String location,
    required List<String> capabilities,
    required int unlockSeconds,
  }) async {
    if (state.busy) return;
    final trimmedName = name.trim();
    final trimmedLocation = location.trim();
    if (trimmedName.isEmpty || trimmedLocation.isEmpty) {
      emit(state.copyWith(error: 'Completa el nombre y la ubicación.'));
      return;
    }
    if (capabilities.isEmpty) {
      emit(state.copyWith(error: 'Elige al menos un componente.'));
      return;
    }
    emit(state.copyWith(action: AdoptAction.adopting, error: null, message: null));
    try {
      final device = await _iot.adoptDiscoveredDevice(
        state.discovered.id,
        name: trimmedName,
        location: trimmedLocation,
        capabilities: capabilities,
        unlockSeconds: unlockSeconds,
      );
      if (isClosed) return;
      emit(state.copyWith(action: AdoptAction.none, adopted: device));
    } on ApiException catch (error) {
      if (isClosed) return;
      emit(state.copyWith(action: AdoptAction.none, error: error.message));
    }
  }

  Future<void> ignore() async {
    if (state.busy) return;
    emit(state.copyWith(action: AdoptAction.ignoring, error: null, message: null));
    try {
      await _iot.ignoreDiscoveredDevice(state.discovered.id);
      if (isClosed) return;
      emit(state.copyWith(action: AdoptAction.none, ignored: true));
    } on ApiException catch (error) {
      if (isClosed) return;
      emit(state.copyWith(action: AdoptAction.none, error: error.message));
    }
  }
}
