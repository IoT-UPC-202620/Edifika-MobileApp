import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/utils/load_status.dart';
import '../../residential/domain/residential_models.dart';
import '../../residential/domain/residential_repository.dart';
import '../domain/iot_models.dart';
import '../domain/iot_repository.dart';

part 'iot_management_cubit.freezed.dart';

/// Conteo de dispositivos por estado para el resumen del edificio.
typedef DeviceSummary = ({int online, int offline, int maintenance, int provisioned, int decommissioned});

@freezed
abstract class IotManagementState with _$IotManagementState {
  const factory IotManagementState({
    /// Carga de la lista de edificios.
    @Default(LoadStatus.loading) LoadStatus buildingsStatus,
    @Default(<Building>[]) List<Building> buildings,
    int? selectedBuildingId,

    /// Carga de gateways y dispositivos del edificio elegido.
    @Default(LoadStatus.loading) LoadStatus status,
    String? error,
    @Default(<IotGateway>[]) List<IotGateway> gateways,
    @Default(<IotDevice>[]) List<IotDevice> devices,

    /// Telemetría por `deviceCode`. Es complementaria: si el servicio falla,
    /// los dispositivos se muestran igual y se avisa con [telemetryUnavailable].
    @Default(<String, DeviceTelemetry>{}) Map<String, DeviceTelemetry> telemetry,
    @Default(false) bool telemetryUnavailable,

    /// Nodos que los gateways del edificio identificaron y esperan ser adoptados.
    /// Complementario: si falla la consulta, la lista queda vacía.
    @Default(<DiscoveredDevice>[]) List<DiscoveredDevice> discovered,

    /// Momento de la última carga exitosa (para "Actualizado hace X s").
    DateTime? updatedAt,
  }) = _IotManagementState;

  const IotManagementState._();

  Building? get selectedBuilding {
    for (final b in buildings) {
      if (b.id == selectedBuildingId) return b;
    }
    return null;
  }

  DeviceSummary get summary {
    int count(String status) => devices.where((d) => d.status.toUpperCase() == status).length;
    return (
      online: count('ACTIVE'),
      offline: count('OFFLINE'),
      maintenance: count('MAINTENANCE'),
      provisioned: count('PROVISIONED'),
      decommissioned: count('DECOMMISSIONED'),
    );
  }

  /// Dispositivos de un gateway, ordenados por nombre.
  List<IotDevice> devicesOf(int gatewayId) =>
      devices.where((d) => d.gatewayId == gatewayId).toList()..sort((a, b) => a.name.compareTo(b.name));

  /// Dispositivos cuyo gateway no vino en la lista (p. ej. un gateway dado de baja).
  List<IotDevice> get devicesWithoutGateway {
    final known = gateways.map((g) => g.id).toSet();
    return devices.where((d) => !known.contains(d.gatewayId)).toList();
  }

  DeviceTelemetry? telemetryOf(IotDevice device) => telemetry[device.deviceCode];

  IotGateway? gatewayOf(IotDevice device) {
    for (final g in gateways) {
      if (g.id == device.gatewayId) return g;
    }
    return null;
  }
}

/// Gestión IoT del administrador: elige un edificio y ve el estado de sus
/// gateways y dispositivos. Solo lectura.
class IotManagementCubit extends Cubit<IotManagementState> {
  IotManagementCubit({
    required IotRepository iot,
    required ResidentialRepository residential,
    DateTime Function()? now,
  })  : _iot = iot,
        _residential = residential,
        _now = now ?? DateTime.now,
        super(const IotManagementState());

  final IotRepository _iot;
  final ResidentialRepository _residential;
  final DateTime Function() _now;

  /// Evita que una respuesta lenta de un edificio anterior pise al actual.
  int _request = 0;

  Timer? _autoRefresh;
  bool _refreshing = false;

  /// El ESP32 publica lecturas y heartbeat cada 10 s: refrescar más seguido no
  /// trae datos nuevos.
  static const liveInterval = Duration(seconds: 10);

  /// Recarga en silencio cada [every] mientras la pantalla está visible.
  void startAutoRefresh([Duration every = liveInterval]) {
    _autoRefresh?.cancel();
    _autoRefresh = Timer.periodic(every, (_) {
      // Sin spinner ni recargas encimadas; tampoco mientras hay un error en pantalla.
      if (_refreshing || state.status != LoadStatus.ready) return;
      refresh();
    });
  }

  void stopAutoRefresh() {
    _autoRefresh?.cancel();
    _autoRefresh = null;
  }

  @override
  Future<void> close() {
    stopAutoRefresh();
    return super.close();
  }

  Future<void> start() async {
    emit(state.copyWith(buildingsStatus: LoadStatus.loading, error: null));
    try {
      final buildings = await _residential.getBuildings()
        ..sort((a, b) => a.name.compareTo(b.name));
      emit(state.copyWith(buildingsStatus: LoadStatus.ready, buildings: buildings));
      if (buildings.isEmpty) {
        emit(state.copyWith(status: LoadStatus.ready));
        return;
      }
      final keep = buildings.any((b) => b.id == state.selectedBuildingId);
      await selectBuilding(keep ? state.selectedBuildingId! : buildings.first.id);
    } on ApiException catch (error) {
      emit(state.copyWith(buildingsStatus: LoadStatus.failure, error: error.message));
    }
  }

  Future<void> selectBuilding(int buildingId) async {
    final request = ++_request;
    emit(state.copyWith(
      selectedBuildingId: buildingId,
      status: LoadStatus.loading,
      error: null,
      gateways: const [],
      devices: const [],
      telemetry: const {},
      telemetryUnavailable: false,
      discovered: const [],
    ));
    await _load(buildingId, request);
  }

  /// Recarga el edificio actual sin vaciar la pantalla (pull-to-refresh).
  Future<void> refresh() async {
    final buildingId = state.selectedBuildingId;
    if (buildingId == null) return start();
    _refreshing = true;
    try {
      await _load(buildingId, ++_request);
    } finally {
      _refreshing = false;
    }
  }

  Future<void> _load(int buildingId, int request) async {
    // Future.sync: un error lanzado antes de devolver el Future también
    // termina en el estado de fallo en vez de escapar del cubit.
    final gatewaysCall = Future.sync(() => _iot.getGateways(buildingId));
    final devicesCall = Future.sync(() => _iot.getDevices(buildingId));
    final telemetryCall = _loadTelemetry(buildingId);
    final discoveredCall = _loadDiscovered(buildingId);
    try {
      final (gateways, devices) = await (gatewaysCall, devicesCall).wait;
      final (byCode, telemetryUnavailable) = await telemetryCall;
      final discovered = await discoveredCall;
      if (request != _request || isClosed) return;
      emit(state.copyWith(
        status: LoadStatus.ready,
        error: null,
        gateways: gateways..sort((a, b) => a.name.compareTo(b.name)),
        devices: devices,
        telemetry: byCode,
        telemetryUnavailable: telemetryUnavailable,
        discovered: discovered,
        updatedAt: _now(),
      ));
    } on ParallelWaitError<(List<IotGateway>?, List<IotDevice>?), (AsyncError?, AsyncError?)> catch (e) {
      final cause = e.errors.$1?.error ?? e.errors.$2?.error;
      if (request != _request || isClosed) return;
      emit(state.copyWith(status: LoadStatus.failure, error: _messageFor(cause)));
    }
  }

  Future<List<DiscoveredDevice>> _loadDiscovered(int buildingId) async {
    try {
      return await _iot.getDiscoveredDevices(buildingId);
    } catch (_) {
      return const <DiscoveredDevice>[];
    }
  }

  Future<(Map<String, DeviceTelemetry>, bool)> _loadTelemetry(int buildingId) async {
    try {
      final list = await _iot.getTelemetry(buildingId);
      return ({for (final t in list) t.deviceCode: t}, false);
    } catch (_) {
      // Complementaria: cualquier falla (red, 5xx, payload inesperado) solo
      // oculta las lecturas.
      return (const <String, DeviceTelemetry>{}, true);
    }
  }

  static String _messageFor(Object? error) {
    if (error is! ApiException) return 'Ocurrió un error inesperado.';
    return switch (error.kind) {
      // La fake API (json-server) no tiene rutas IoT y responde 404.
      ApiErrorKind.notFound =>
        'El servicio IoT no está disponible en el servidor configurado. La fake API no incluye dispositivos; '
            'apunta API_BASE_URL al API Gateway de los microservicios.',
      ApiErrorKind.unauthorized => 'Tu cuenta no tiene permisos de administrador para ver los dispositivos IoT.',
      _ => error.message,
    };
  }
}
