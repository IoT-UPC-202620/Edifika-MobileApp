import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/live_refresh.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/presentation/session_cubit.dart';
import '../../profile/presentation/account_sheet.dart';
import '../../residential/domain/residential_models.dart';
import '../domain/iot_models.dart';
import 'iot_labels.dart';
import 'iot_management_cubit.dart';
import 'iot_routes_args.dart';

/// Gestión IoT del administrador (sin diseño en Figma; usa los tokens de la
/// app). Elige un edificio y muestra sus gateways y dispositivos con estado.
class IotManagementScreen extends StatelessWidget {
  const IotManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IotManagementCubit(iot: context.read(), residential: context.read())
        ..start()
        ..startAutoRefresh(),
      child: BlocBuilder<IotManagementCubit, IotManagementState>(
        builder: (context, state) {
          final cubit = context.read<IotManagementCubit>();
          final user = context.select((SessionCubit s) => s.state.user);
          final building = state.selectedBuilding;
          return PauseWhenInBackground(
            onPause: cubit.stopAutoRefresh,
            onResume: () => cubit
              ..refresh()
              ..startAutoRefresh(),
            child: ScreenScaffold(
            title: 'Gestión IoT',
            location: building == null ? null : _buildingLocation(building),
            // Se abre desde el Inicio del administrador: muestra volver.
            showBack: GoRouter.of(context).canPop(),
            onRefresh: cubit.refresh,
            trailing: IconButton(
              tooltip: 'Mi cuenta',
              onPressed: () => showAccountSheet(context),
              icon: InitialsAvatar(user?.fullName ?? ''),
            ),
            body: switch (state.buildingsStatus) {
              LoadStatus.loading => const LoadingView(message: 'Cargando edificios…'),
              LoadStatus.failure => ErrorView(message: state.error ?? '', onRetry: cubit.start),
              LoadStatus.ready when state.buildings.isEmpty =>
                const EmptyView(message: 'No hay edificios registrados.', icon: Icons.apartment_outlined),
              LoadStatus.ready => _BuildingContent(state: state),
            },
            ),
          );
        },
      ),
    );
  }
}

String _buildingLocation(Building b) =>
    [b.address, b.district, b.city].where((part) => part.isNotEmpty).join(' · ');

class _BuildingContent extends StatelessWidget {
  const _BuildingContent({required this.state});

  final IotManagementState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<IotManagementCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LabeledField(
          label: 'Edificio',
          child: DropdownButtonFormField<int>(
            // initialValue solo se lee al crear el campo: la key lo recrea si
            // la selección cambia desde el cubit.
            key: ValueKey(state.selectedBuildingId),
            initialValue: state.selectedBuildingId,
            isExpanded: true,
            items: [
              for (final b in state.buildings) DropdownMenuItem(value: b.id, child: Text(b.name, overflow: TextOverflow.ellipsis)),
            ],
            onChanged: (id) {
              if (id != null && id != state.selectedBuildingId) cubit.selectBuilding(id);
            },
          ),
        ),
        ...switch (state.status) {
          LoadStatus.loading => [const LoadingView(message: 'Cargando dispositivos…')],
          LoadStatus.failure => [
              ErrorView(
                message: state.error ?? '',
                onRetry: () => cubit.selectBuilding(state.selectedBuildingId!),
              ),
            ],
          LoadStatus.ready => _readyContent(context),
        },
      ],
    );
  }

  List<Widget> _readyContent(BuildContext context) {
    if (state.gateways.isEmpty && state.devices.isEmpty) {
      return const [
        EmptyView(
          icon: Icons.router_outlined,
          message: 'Este edificio aún no tiene un gateway. Registra el gateway en el backend; '
              'los dispositivos que se anuncien en su red aparecerán aquí para adoptarlos.',
        ),
      ];
    }
    return [
      if (state.discovered.isNotEmpty) ...[
        const SizedBox(height: AppSpacing.md),
        _DiscoveredBanner(state: state),
        const SizedBox(height: AppSpacing.md),
      ],
      _SummaryGrid(summary: state.summary),
      const SizedBox(height: AppSpacing.md),
      _CardsEntry(state: state),
      const SizedBox(height: AppSpacing.sm),
      Align(alignment: Alignment.centerRight, child: UpdatedAgo(at: state.updatedAt)),
      if (state.telemetryUnavailable) ...[
        const SizedBox(height: AppSpacing.md),
        const InfoBanner(
          title: 'Telemetría no disponible',
          message: 'No se pudieron obtener las lecturas de sensores. El estado de los dispositivos sí está actualizado.',
        ),
      ],
      for (final gateway in state.gateways) ..._gatewaySection(context, gateway, state.devicesOf(gateway.id)),
      if (state.devicesWithoutGateway.isNotEmpty) ...[
        const SectionHeader('Otros dispositivos'),
        for (final device in state.devicesWithoutGateway) ...[
          _DeviceCard(device: device, telemetry: state.telemetryOf(device), gateway: null),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    ];
  }

  List<Widget> _gatewaySection(BuildContext context, IotGateway gateway, List<IotDevice> devices) {
    return [
      const SizedBox(height: AppSpacing.xxl),
      _GatewayCard(gateway: gateway, deviceCount: devices.length),
      const SizedBox(height: AppSpacing.md),
      if (devices.isEmpty)
        const EmptyView(message: 'Este gateway no tiene dispositivos registrados.', icon: Icons.sensors_off_outlined)
      else
        for (final device in devices) ...[
          _DeviceCard(device: device, telemetry: state.telemetryOf(device), gateway: gateway),
          const SizedBox(height: AppSpacing.md),
        ],
    ];
  }
}

/// Aviso de nodos identificados por los gateways que esperan ser adoptados.
class _DiscoveredBanner extends StatelessWidget {
  const _DiscoveredBanner({required this.state});

  final IotManagementState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final count = state.discovered.length;
    final building = state.selectedBuilding;
    return AppCard(
      tone: AppCardTone.highlighted,
      onTap: building == null
          ? null
          : () async {
              final cubit = context.read<IotManagementCubit>()..stopAutoRefresh();
              await context.push(
                '/admin/iot/discovered',
                extra: IotDiscoveredArgs(buildingId: building.id, buildingName: building.name, gateways: state.gateways),
              );
              if (cubit.isClosed) return;
              await cubit.refresh();
              cubit.startAutoRefresh();
            },
      child: Row(
        children: [
          const Icon(Icons.add_circle_outline, color: AppColors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(count == 1 ? '1 dispositivo nuevo' : '$count dispositivos nuevos', style: textTheme.titleMedium),
                Text('El gateway los identificó. Revísalos y adóptalos.', style: textTheme.bodySmall),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
        ],
      ),
    );
  }
}

/// Acceso a las tarjetas RFID del edificio (listar, registrar y asignar).
class _CardsEntry extends StatelessWidget {
  const _CardsEntry({required this.state});

  final IotManagementState state;

  @override
  Widget build(BuildContext context) {
    final building = state.selectedBuilding;
    final readers = state.devices.where((d) => d.capabilities.any((c) => c.toUpperCase() == 'RFID')).toList();
    return AppCard(
      onTap: building == null
          ? null
          : () async {
              final cubit = context.read<IotManagementCubit>()..stopAutoRefresh();
              await context.push(
                '/admin/iot/cards',
                extra: IotCardsArgs(
                  buildingId: building.id,
                  buildingName: building.name,
                  readers: readers,
                  gateways: state.gateways,
                ),
              );
              if (cubit.isClosed) return;
              await cubit.refresh();
              cubit.startAutoRefresh();
            },
      child: Row(
        children: [
          const Icon(Icons.badge_outlined, color: AppColors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tarjetas RFID', style: Theme.of(context).textTheme.titleMedium),
                Text(
                  'Lee tarjetas en un lector y asígnalas a los usuarios',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
        ],
      ),
    );
  }
}

/// Resumen de dispositivos por estado. Los dados de baja no se cuentan.
class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid({required this.summary});

  final DeviceSummary summary;

  @override
  Widget build(BuildContext context) {
    final items = [
      ('En línea', summary.online, AppColors.success),
      ('Sin conexión', summary.offline, AppColors.error),
      ('Mantenimiento', summary.maintenance, AppColors.primary),
      ('Por activar', summary.provisioned, AppColors.onSurfaceVariant),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - AppSpacing.md) / 2;
        return Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            for (final (label, count, color) in items)
              SizedBox(
                width: width,
                child: Semantics(
                  label: '$label: $count',
                  excludeSemantics: true,
                  child: AppCard(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$count', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: color)),
                        const SizedBox(height: AppSpacing.xs),
                        Text(label, style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _GatewayCard extends StatelessWidget {
  const _GatewayCard({required this.gateway, required this.deviceCount});

  final IotGateway gateway;
  final int deviceCount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final (label, tone) = IotLabels.gatewayStatus(gateway.status);
    return AppCard(
      tone: AppCardTone.highlighted,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.router_outlined, color: AppColors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gateway · ${gateway.name}', style: textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(gateway.gatewayCode, style: textTheme.bodySmall),
                const SizedBox(height: AppSpacing.xs),
                Text('Sincronizado: ${Formatters.instant(gateway.lastSyncAt)}', style: textTheme.bodySmall),
                Text(
                  deviceCount == 1 ? '1 dispositivo' : '$deviceCount dispositivos',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
          StatusChip(label, tone: tone, onTinted: true),
        ],
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({required this.device, required this.telemetry, required this.gateway});

  final IotDevice device;
  final DeviceTelemetry? telemetry;
  final IotGateway? gateway;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final (label, tone) = IotLabels.deviceStatus(device.status);
    final readings = telemetry?.latest ?? const <SensorReading>[];
    return AppCard(
      onTap: () async {
        final cubit = context.read<IotManagementCubit>()..stopAutoRefresh(); // el detalle refresca lo suyo
        await context.push(
          '/admin/iot/device',
          extra: IotDeviceDetailArgs(device: device, gateway: gateway, telemetry: telemetry),
        );
        if (cubit.isClosed) return;
        // Al volver, refleja lo que haya cambiado (reserva, color del LED) y sigue en vivo.
        await cubit.refresh();
        cubit.startAutoRefresh();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(IotLabels.deviceIcon(device.deviceType), color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Text(device.name, style: textTheme.titleMedium)),
              StatusChip(label, tone: tone),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            [IotLabels.deviceType(device.deviceType), if (device.location.isNotEmpty) device.location].join(' · '),
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text('Última conexión: ${Formatters.instant(device.lastSeenAt)}', style: textTheme.bodySmall),
          if (readings.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.lg,
              runSpacing: AppSpacing.xs,
              children: [
                for (final r in readings)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(IotLabels.magnitude(r.magnitude).icon, size: 16, color: AppColors.onSurfaceVariant),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '${IotLabels.magnitude(r.magnitude).label}: ${IotLabels.reading(r.value, r.unit)}',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
