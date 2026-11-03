import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../profile/domain/profile_repository.dart';
import '../../profile/domain/user_profile.dart';
import '../../residential/domain/residential_repository.dart';
import '../domain/iot_models.dart';
import '../domain/iot_repository.dart';
import 'iot_labels.dart';

part 'iot_device_control_cubit.freezed.dart';

/// Envío de un color al LED: el backend acepta el comando (`PENDING`) y el
/// nodo lo confirma después.
enum LedCommandStatus { idle, sending, waiting, applied, rejected }

@freezed
abstract class IotDeviceControlState with _$IotDeviceControlState {
  const factory IotDeviceControlState({
    required IotDevice device,

    /// Últimas lecturas del dispositivo; se refrescan mientras la pantalla está abierta.
    DeviceTelemetry? telemetry,

    /// Momento de la última actualización exitosa del dispositivo.
    DateTime? updatedAt,

    /// Última reserva creada desde esta pantalla.
    DoorReservation? reservation,
    @Default(false) bool reserving,
    @Default(LedCommandStatus.idle) LedCommandStatus ledStatus,
    String? requestedColor,

    /// Motivo cuando el backend o el nodo rechazan el color.
    String? ledError,

    /// Sesión de modo registro en el lector (`ACTIVE`, `CAPTURED`, `EXPIRED` o `CANCELLED`).
    CardEnrollment? enrollment,
    @Default(false) bool enrolling,
    @Default(0) int enrollmentSecondsLeft,
    @Default(<UserProfile>[]) List<UserProfile> residents,
    @Default(false) bool loadingResidents,
    int? selectedResidentId,
    @Default(false) bool creatingCredential,
    AccessCredential? createdCredential,
    String? enrollmentError,

    /// Aviso puntual para un SnackBar.
    String? message,
  }) = _IotDeviceControlState;

  const IotDeviceControlState._();

  bool get isReserved => device.accessMode.toUpperCase() == 'RESERVED';
  bool get isOnline => device.status.toUpperCase() == 'ACTIVE';
  bool get hasRgbLed => device.capabilities.any((c) => c.toUpperCase() == 'RGB_LED');
  bool get hasRfid => device.capabilities.any((c) => c.toUpperCase() == 'RFID');

  /// El backend solo acepta el color con la puerta en línea y reservada.
  bool get canSetLed =>
      hasRgbLed &&
      isOnline &&
      isReserved &&
      ledStatus != LedCommandStatus.sending &&
      ledStatus != LedCommandStatus.waiting;

  bool get isWaitingCard => enrollment != null && enrollment!.isActive;

  bool get canStartEnrollment => hasRfid && isOnline && !enrolling && !isWaitingCard && !creatingCredential;

  UserProfile? get selectedResident {
    final id = selectedResidentId;
    if (id == null) return null;
    for (final r in residents) {
      if (r.id == id) return r;
    }
    return null;
  }

  bool get canAssignCard {
    final e = enrollment;
    return e != null &&
        e.isCaptured &&
        (e.capturedUid?.isNotEmpty ?? false) &&
        (e.existingCredential == null || IotLabels.isRetiredCredential(e.existingCredential!.status)) &&
        selectedResident != null &&
        !creatingCredential;
  }
}

/// Acciones del administrador sobre un dispositivo: reservar la puerta a su
/// nombre, cambiar el color del LED RGB y registrar tarjetas RFID.
class IotDeviceControlCubit extends Cubit<IotDeviceControlState> {
  IotDeviceControlCubit(
    this._iot, {
    ProfileRepository? profile,
    ResidentialRepository? residential,
    required IotDevice device,
    DeviceTelemetry? telemetry,
    DateTime Function()? now,
    this.pollInterval = const Duration(seconds: 1),
    this.maxWait = const Duration(seconds: 15),
  })  : _profile = profile,
        _residential = residential,
        _now = now ?? DateTime.now,
        super(IotDeviceControlState(device: device, telemetry: telemetry));

  final IotRepository _iot;
  final ProfileRepository? _profile;
  final ResidentialRepository? _residential;
  final DateTime Function() _now;
  final Duration pollInterval;

  /// Tope de espera de la confirmación (el backend expira el comando a los 10 s).
  final Duration maxWait;

  Timer? _autoRefresh;
  bool _refreshing = false;
  int _enrollmentToken = 0;
  Future<void>? _residentsFuture;

  /// Mismo ritmo con que el ESP32 publica lecturas y heartbeat.
  static const liveInterval = Duration(seconds: 10);

  /// Actualiza estado y lecturas cada [every] mientras la pantalla está visible.
  void startAutoRefresh([Duration every = liveInterval]) {
    _autoRefresh?.cancel();
    _autoRefresh = Timer.periodic(every, (_) => refreshLive());
  }

  void stopAutoRefresh() {
    _autoRefresh?.cancel();
    _autoRefresh = null;
  }

  /// Recarga en silencio el dispositivo y sus últimas lecturas. Si una de las
  /// dos falla se conserva el último valor conocido.
  Future<void> refreshLive() async {
    if (_refreshing || isClosed) return;
    _refreshing = true;
    try {
      final deviceCall = _refreshDevice();
      final telemetryCall = _refreshTelemetry();
      final device = await deviceCall;
      final telemetry = await telemetryCall;
      if (isClosed) return;
      emit(state.copyWith(
        device: device ?? state.device,
        telemetry: telemetry ?? state.telemetry,
        updatedAt: device != null || telemetry != null ? _now() : state.updatedAt,
      ));
    } finally {
      _refreshing = false;
    }
  }

  Future<DeviceTelemetry?> _refreshTelemetry() async {
    try {
      return await _iot.getDeviceTelemetry(state.device.deviceCode);
    } on ApiException {
      return null;
    }
  }

  @override
  Future<void> close() {
    stopAutoRefresh();
    _enrollmentToken++;
    if (state.isWaitingCard) {
      _iot.cancelEnrollment(state.device.id).ignore();
    }
    return super.close();
  }

  /// Reserva la puerta desde ahora y por [duration], a nombre del usuario actual.
  Future<void> reserveForMe(Duration duration) async {
    if (state.reserving) return;
    emit(state.copyWith(reserving: true, message: null));
    try {
      final start = _now();
      final reservation = await _iot.createReservation(state.device.id, startsAt: start, endsAt: start.add(duration));
      emit(state.copyWith(
        reserving: false,
        reservation: reservation,
        ledStatus: LedCommandStatus.idle,
        ledError: null,
        message: 'Puerta reservada a tu nombre.',
      ));
      await _waitUntilReserved();
    } on ApiException catch (error) {
      emit(state.copyWith(reserving: false, message: error.message));
    }
  }

  /// La reserva puede quedar `SCHEDULED` unos instantes (el servidor la activa
  /// en su ciclo, y el reloj del teléfono puede ir adelantado). Se consulta la
  /// puerta hasta que figure `RESERVED` o se agote [maxWait].
  Future<void> _waitUntilReserved() async {
    final deadline = _now().add(maxWait);
    while (!isClosed) {
      final device = await _refreshDevice();
      if (isClosed) return;
      if (device != null) emit(state.copyWith(device: device));
      if (state.isReserved || !_now().isBefore(deadline)) return;
      await Future<void>.delayed(pollInterval);
    }
  }

  /// Hay una reserva creada desde esta pantalla que aún no termina.
  bool get hasPendingReservation {
    final r = state.reservation;
    if (r == null) return false;
    final ends = DateTime.tryParse(r.endsAt);
    return ends != null && _now().isBefore(ends) && !const {'ENDED', 'CANCELLED'}.contains(r.status.toUpperCase());
  }

  /// Envía el color y espera la confirmación del nodo.
  Future<void> setLedColor(String color) async {
    if (!state.canSetLed) return;
    emit(state.copyWith(ledStatus: LedCommandStatus.sending, requestedColor: color, ledError: null, message: null));
    try {
      var command = await _iot.setLedColor(state.device.id, color);
      emit(state.copyWith(ledStatus: LedCommandStatus.waiting));

      final deadline = _now().add(maxWait);
      while (command.isPending && _now().isBefore(deadline)) {
        await Future<void>.delayed(pollInterval);
        if (isClosed) return;
        command = await _iot.getCommand(command.commandId);
      }
      if (isClosed) return;

      final device = await _refreshDevice();
      final applied = command.status.toUpperCase() == 'OK';
      emit(state.copyWith(
        device: device ?? state.device,
        ledStatus: applied ? LedCommandStatus.applied : LedCommandStatus.rejected,
        ledError: applied ? null : _commandFailure(command),
      ));
    } on ApiException catch (error) {
      emit(state.copyWith(ledStatus: LedCommandStatus.rejected, ledError: error.message));
    }
  }

  /// Inicia el modo registro al abrir la pantalla si se pidió (desde "Tarjetas RFID").
  void startEnrollmentIf(bool requested) {
    if (requested) unawaited(startEnrollment());
  }

  /// Pone el lector en modo registro (60 s) y espera a que capture una tarjeta.
  Future<void> startEnrollment() async {
    if (!state.canStartEnrollment) return;
    final token = ++_enrollmentToken;
    emit(state.copyWith(
      enrolling: true,
      enrollment: null,
      enrollmentError: null,
      createdCredential: null,
      message: null,
    ));
    unawaited(_ensureResidents());
    try {
      final session = await _iot.startEnrollment(state.device.id);
      if (isClosed || token != _enrollmentToken) return;
      emit(state.copyWith(
        enrolling: false,
        enrollment: session,
        enrollmentSecondsLeft: _remainingSeconds(session.expiresAt),
      ));
      await _pollEnrollment(token, session);
    } on ApiException catch (error) {
      if (isClosed || token != _enrollmentToken) return;
      emit(state.copyWith(enrolling: false, enrollmentError: error.message));
    }
  }

  Future<void> _pollEnrollment(int token, CardEnrollment initial) async {
    var current = initial;
    while (!isClosed && token == _enrollmentToken && current.isActive) {
      await Future<void>.delayed(pollInterval);
      if (isClosed || token != _enrollmentToken) return;
      try {
        final latest = await _iot.getEnrollment(state.device.id);
        if (isClosed || token != _enrollmentToken) return;
        if (latest == null) {
          emit(state.copyWith(enrollment: null, enrollmentSecondsLeft: 0));
          return;
        }
        current = latest;
        if (current.isCaptured) {
          await _ensureResidents();
          if (isClosed || token != _enrollmentToken) return;
          emit(state.copyWith(
            enrollment: current,
            enrollmentSecondsLeft: 0,
            selectedResidentId: state.selectedResidentId ?? _defaultHolder(state.residents),
          ));
          return;
        }
        final remaining = _remainingSeconds(current.expiresAt);
        if (!current.isActive || remaining <= 0) {
          final finished = current.isActive ? current.copyWith(status: 'EXPIRED') : current;
          emit(state.copyWith(enrollment: finished, enrollmentSecondsLeft: 0));
          return;
        }
        emit(state.copyWith(enrollment: current, enrollmentSecondsLeft: remaining));
      } on ApiException catch (error) {
        if (isClosed || token != _enrollmentToken) return;
        emit(state.copyWith(enrollmentError: error.message));
        return;
      }
    }
  }

  /// Sale del modo registro o descarta la tarjeta capturada sin asociarla.
  Future<void> cancelEnrollment() async {
    _enrollmentToken++;
    final wasActive = state.isWaitingCard;
    emit(state.copyWith(
      enrolling: false,
      enrollment: null,
      enrollmentSecondsLeft: 0,
      enrollmentError: null,
    ));
    if (wasActive) {
      try {
        await _iot.cancelEnrollment(state.device.id);
      } on ApiException {
        // Si ya venció en el backend, la sesión igual queda cerrada en la app.
      }
    }
  }

  void selectResident(int userId) {
    emit(state.copyWith(selectedResidentId: userId, enrollmentError: null));
  }

  /// Asocia la tarjeta capturada al residente elegido (`POST /access/credentials`).
  Future<void> assignCapturedCard() async {
    if (!state.canAssignCard) return;
    final uid = state.enrollment!.capturedUid!;
    final resident = state.selectedResident!;
    emit(state.copyWith(creatingCredential: true, enrollmentError: null, message: null));
    try {
      final credential = await _iot.createCredential(
        rfidUid: uid,
        buildingId: state.device.buildingId,
        userId: resident.id,
        holderName: resident.fullName,
      );
      if (isClosed) return;
      emit(state.copyWith(
        creatingCredential: false,
        enrollment: null,
        enrollmentSecondsLeft: 0,
        createdCredential: credential,
        message: 'Tarjeta asociada a ${resident.fullName}.',
      ));
    } on ApiException catch (error) {
      if (isClosed) return;
      emit(state.copyWith(creatingCredential: false, enrollmentError: error.message));
    }
  }

  Future<void> _ensureResidents() {
    if (state.residents.isNotEmpty || _profile == null) return Future.value();
    return _residentsFuture ??= _loadResidents().whenComplete(() => _residentsFuture = null);
  }

  Future<void> _loadResidents() async {
    final profile = _profile;
    if (profile == null || isClosed) return;
    emit(state.copyWith(loadingResidents: true));
    try {
      final users = await profile.getUsers();
      var candidates = users;
      final residential = _residential;
      if (residential != null) {
        try {
          final relations = await residential.getBuildingResidents(state.device.buildingId);
          // Primero los residentes del edificio; el resto de usuarios sigue disponible
          // (p. ej. el propietario por defecto aún sin unidad asignada en Residential).
          final activeIds = relations.where((r) => r.isActive).map((r) => r.idUser).toSet();
          final inBuilding = users.where((u) => activeIds.contains(u.id)).toList();
          final others = users.where((u) => !activeIds.contains(u.id)).toList();
          candidates = [...inBuilding, ...others];
        } on ApiException {
          // Si Residential no responde, se muestra la lista general de usuarios.
        }
      }
      if (isClosed) return;
      emit(state.copyWith(
        residents: candidates,
        loadingResidents: false,
        selectedResidentId: state.selectedResidentId ?? _defaultHolder(candidates),
      ));
    } on ApiException catch (error) {
      if (isClosed) return;
      emit(state.copyWith(loadingResidents: false, enrollmentError: error.message));
    }
  }

  /// Usuario elegido de entrada: el primero que no es solo administrador.
  static int? _defaultHolder(List<UserProfile> users) {
    for (final u in users) {
      if (IotLabels.userRole(u.roles) != 'Administrador') return u.id;
    }
    return users.firstOrNull?.id;
  }

  int _remainingSeconds(String expiresAt) {
    final end = DateTime.tryParse(expiresAt);
    if (end == null) return 60;
    final diff = end.difference(_now()).inSeconds;
    return diff.clamp(0, 60);
  }

  Future<IotDevice?> _refreshDevice() async {
    try {
      return await _iot.getDevice(state.device.id);
    } on ApiException {
      return null; // Se mantiene el último estado conocido.
    }
  }

  static String _commandFailure(DeviceCommand command) => switch (command.status.toUpperCase()) {
        'PENDING' || 'EXPIRED' => 'El dispositivo no confirmó el cambio a tiempo. Revisa que esté conectado.',
        _ => switch (command.detail) {
            'not reserved' => 'El dispositivo rechazó el cambio: la puerta no está reservada.',
            final String detail when detail.isNotEmpty => 'El dispositivo rechazó el cambio: $detail.',
            _ => 'El dispositivo rechazó el cambio.',
          },
      };
}
