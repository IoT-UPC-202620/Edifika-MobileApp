import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../../access/data/access_repository.dart';
import '../../access/domain/access_models.dart';
import '../../auth/presentation/session_cubit.dart';
import '../../iot/domain/iot_models.dart' show DeviceTelemetry;
import '../../profile/presentation/account_sheet.dart';

/// Inicio del administrador: alertas IoT abiertas, accesos denegados recientes y
/// dispositivos sin conexion. Desde aqui se entra a la Gestion IoT.
class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _Summary {
  const _Summary(this.alerts, this.denied, this.offline);

  final List<TelemetryAlert> alerts;
  final List<AccessAttempt> denied;
  final List<DeviceTelemetry> offline;
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  static const _refreshEvery = Duration(seconds: 30);

  late Future<_Summary> _future = _load();
  _Summary? _last;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Se actualiza solo, como el dashboard web (sin mostrar "cargando" en cada vuelta).
    _timer = Timer.periodic(_refreshEvery, (_) => _silentRefresh());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _silentRefresh() async {
    try {
      final next = await _load();
      if (mounted) setState(() {
        _future = Future.value(next);
      });
    } catch (error) {
      // Se mantiene el ultimo resumen; el usuario puede reintentar con "deslizar para refrescar".
      debugPrint('AdminHome: refresco fallido: $error');
    }
  }

  Future<_Summary> _load() async {
    final repository = context.read<AccessRepository>();
    final results = await Future.wait([
      repository.openAlerts(),
      repository.recentDenied(),
      repository.allDevices(),
    ]);
    final devices = results[2] as List<DeviceTelemetry>;
    return _last = _Summary(
      results[0] as List<TelemetryAlert>,
      results[1] as List<AccessAttempt>,
      devices.where((d) => d.connectionStatus.toUpperCase() != 'ACTIVE').toList(),
    );
  }

  Future<void> _refresh() async {
    final next = _load();
    setState(() {
        _future = next;
      });
    await next.catchError((_) => const _Summary([], [], []));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((SessionCubit s) => s.state.user);
    return ScreenScaffold(
      title: 'Inicio',
      location: 'Administración',
      showBack: false,
      onRefresh: _refresh,
      trailing: IconButton(
        tooltip: 'Mi cuenta',
        onPressed: () => showAccountSheet(context),
        icon: InitialsAvatar(user?.fullName.isNotEmpty == true ? user!.fullName : (user?.email ?? '')),
      ),
      body: FutureBuilder<_Summary>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done && _last == null) {
            return const LoadingView(message: 'Cargando resumen…');
          }
          if (snapshot.hasError) {
            final error = snapshot.error;
            return ErrorView(message: error is ApiException ? error.message : '$error', onRetry: _refresh);
          }
          final data = snapshot.data ?? _last!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(child: _Kpi(label: 'Alertas abiertas', value: data.alerts.length, danger: data.alerts.isNotEmpty)),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: _Kpi(label: 'Sin conexión', value: data.offline.length, danger: data.offline.isNotEmpty)),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: _Kpi(label: 'Denegados', value: data.denied.length, danger: false)),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton.icon(
                onPressed: () => context.push('/admin/iot'),
                icon: const Icon(Icons.sensors),
                label: const Text('Gestión IoT'),
              ),
              const SectionHeader('Alertas IoT abiertas'),
              if (data.alerts.isEmpty) const EmptyView(message: 'Sin alertas abiertas.', icon: Icons.check_circle_outline),
              for (final alert in data.alerts) ...[
                AppCard(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: AppColors.error),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${alert.deviceCode} · ${alert.kindLabel}', style: textTheme.titleSmall),
                            Text(
                              [if (alert.message != null) alert.message!, Formatters.instant(alert.occurredAt)].join(' · '),
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              const SectionHeader('Últimos accesos denegados'),
              if (data.denied.isEmpty) const EmptyView(message: 'Sin accesos denegados.', icon: Icons.verified_user_outlined),
              for (final attempt in data.denied) ...[
                AppCard(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  child: Row(
                    children: [
                      const Icon(Icons.block, color: AppColors.error),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${attempt.deviceCode} · ${attempt.rfidUidMasked ?? 'sin tarjeta'}', style: textTheme.titleSmall),
                            Text(
                              '${AccessLabels.reason(attempt.reason)} · ${Formatters.instant(attempt.occurredAt)}',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              const SectionHeader('Dispositivos sin conexión'),
              if (data.offline.isEmpty) const EmptyView(message: 'Todos los dispositivos están en línea.', icon: Icons.wifi),
              for (final device in data.offline) ...[
                AppCard(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  child: Row(
                    children: [
                      const Icon(Icons.wifi_off),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(device.name.isEmpty ? device.deviceCode : device.name, style: textTheme.titleSmall),
                            Text('Último heartbeat: ${Formatters.instant(device.lastHeartbeatAt)}', style: textTheme.bodySmall),
                          ],
                        ),
                      ),
                      const StatusChip('Sin conexión', tone: StatusTone.danger),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _Kpi extends StatelessWidget {
  const _Kpi({required this.label, required this.value, required this.danger});

  final String label;
  final int value;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      tone: AppCardTone.highlighted,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$value', style: textTheme.headlineSmall?.copyWith(color: danger ? AppColors.error : null)),
          Text(label, style: textTheme.labelSmall),
        ],
      ),
    );
  }
}
