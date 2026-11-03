import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../domain/iot_models.dart';
import 'iot_discovery_cubit.dart';
import 'iot_labels.dart';
import 'iot_routes_args.dart';

/// Componentes que puede declarar un nodo de puerta, en el orden en que se muestran.
const _allCapabilities = ['RFID', 'LOCK', 'BUZZER', 'OLED', 'RGB_LED', 'TEMPERATURE', 'HUMIDITY'];

/// Nodos que los gateways del edificio identificaron sin estar registrados.
class IotDiscoveredScreen extends StatelessWidget {
  const IotDiscoveredScreen({super.key, required this.args});

  final IotDiscoveredArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IotDiscoveryCubit(context.read(), buildingId: args.buildingId)..load(),
      child: BlocConsumer<IotDiscoveryCubit, IotDiscoveryState>(
        listenWhen: (a, b) => b.message != null && a.message != b.message,
        listener: (context, state) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!))),
        builder: (context, state) {
          final cubit = context.read<IotDiscoveryCubit>();
          return ScreenScaffold(
            title: 'Dispositivos nuevos',
            location: args.buildingName,
            onRefresh: cubit.refresh,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const InfoBanner(
                  title: 'Identificados por el gateway',
                  message: 'Estos dispositivos se anunciaron en la red del edificio pero aún no están registrados. '
                      'No abren la puerta ni envían datos hasta que los adoptes.',
                  icon: Icons.sensors_outlined,
                ),
                const SizedBox(height: AppSpacing.md),
                ...switch (state.status) {
                  LoadStatus.loading => [const LoadingView(message: 'Buscando dispositivos…')],
                  LoadStatus.failure => [ErrorView(message: state.error ?? '', onRetry: cubit.load)],
                  LoadStatus.ready when state.devices.isEmpty => [
                      const EmptyView(
                        message: 'No hay dispositivos esperando. Enciende el nuevo dispositivo cerca del gateway '
                            'y espera unos segundos.',
                        icon: Icons.sensors_off_outlined,
                      ),
                    ],
                  LoadStatus.ready => [
                      for (final device in state.devices) ...[
                        _DiscoveredTile(device: device, args: args),
                        const SizedBox(height: AppSpacing.md),
                      ],
                    ],
                },
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DiscoveredTile extends StatelessWidget {
  const _DiscoveredTile({required this.device, required this.args});

  final DiscoveredDevice device;
  final IotDiscoveredArgs args;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final gateway = args.gatewayName(device.gatewayId) ?? device.gatewayCode;
    return AppCard(
      onTap: () async {
        final cubit = context.read<IotDiscoveryCubit>();
        await context.push('/admin/iot/adopt', extra: IotAdoptArgs(discovered: device, gatewayName: gateway));
        if (!cubit.isClosed) await cubit.refresh();
      },
      child: Row(
        children: [
          const Icon(Icons.memory_outlined, color: AppColors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(device.deviceCode, style: textTheme.titleMedium),
                Text(
                  [if (device.model != null) device.model!, device.firmware, 'Gateway $gateway'].join(' · '),
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text('Código en pantalla: ${device.pairingCode}', style: textTheme.labelMedium),
                Text('Visto: ${Formatters.instant(device.lastSeenAt)}', style: textTheme.bodySmall),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
        ],
      ),
    );
  }
}

/// Adopción de un nodo: se comprueba el código en su pantalla, se puede identificar
/// la placa y se completan sus datos.
class IotAdoptScreen extends StatefulWidget {
  const IotAdoptScreen({super.key, required this.args});

  final IotAdoptArgs args;

  @override
  State<IotAdoptScreen> createState() => _IotAdoptScreenState();
}

class _IotAdoptScreenState extends State<IotAdoptScreen> {
  static const _unlockOptions = [3, 5, 10];

  final _name = TextEditingController();
  final _location = TextEditingController();
  late final Set<String> _capabilities;
  int _unlockSeconds = 5;

  @override
  void initState() {
    super.initState();
    final announced = widget.args.discovered.capabilities.map((c) => c.toUpperCase()).toSet();
    _capabilities = announced.isEmpty ? _allCapabilities.toSet() : announced;
  }

  @override
  void dispose() {
    _name.dispose();
    _location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final discovered = widget.args.discovered;
    return BlocProvider(
      create: (context) => IotAdoptCubit(context.read(), discovered: discovered),
      child: BlocConsumer<IotAdoptCubit, IotAdoptState>(
        listener: (context, state) {
          final messenger = ScaffoldMessenger.of(context);
          if (state.adopted != null) {
            messenger.showSnackBar(SnackBar(content: Text('${state.adopted!.name} adoptado. Se activará en unos segundos.')));
            context.pop(true);
          } else if (state.ignored) {
            messenger.showSnackBar(SnackBar(content: Text('${discovered.deviceCode} ignorado.')));
            context.pop(true);
          } else if (state.message != null) {
            messenger.showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        listenWhen: (a, b) =>
            (b.adopted != null && a.adopted == null) ||
            (b.ignored && !a.ignored) ||
            (b.message != null && a.message != b.message),
        builder: (context, state) {
          final cubit = context.read<IotAdoptCubit>();
          final textTheme = Theme.of(context).textTheme;
          return ScreenScaffold(
            title: 'Adoptar dispositivo',
            location: '${discovered.deviceCode} · Gateway ${widget.args.gatewayName}',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PairingCodeCard(code: discovered.pairingCode),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton.icon(
                  onPressed: state.busy ? null : cubit.identify,
                  icon: state.action == AdoptAction.identifying
                      ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.highlight_outlined),
                  label: const Text('Identificar (parpadea y suena)'),
                ),
                const SectionHeader('Datos del dispositivo'),
                LabeledField(
                  label: 'Nombre',
                  child: TextField(
                    controller: _name,
                    enabled: !state.busy,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(hintText: 'Puerta gimnasio'),
                  ),
                ),
                LabeledField(
                  label: 'Ubicación',
                  child: TextField(
                    controller: _location,
                    enabled: !state.busy,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(hintText: 'Piso 2'),
                  ),
                ),
                LabeledField(
                  label: 'Tipo',
                  child: Text(IotLabels.deviceType('DOOR'), style: textTheme.bodyLarge),
                ),
                LabeledField(
                  label: 'Apertura de la cerradura',
                  child: SegmentedButton<int>(
                    segments: [
                      for (final s in _unlockOptions) ButtonSegment(value: s, label: Text('$s s')),
                    ],
                    selected: {_unlockSeconds},
                    showSelectedIcon: false,
                    onSelectionChanged: state.busy ? null : (value) => setState(() => _unlockSeconds = value.first),
                  ),
                ),
                LabeledField(
                  label: 'Componentes',
                  child: Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final c in _allCapabilities)
                        FilterChip(
                          label: Text(IotLabels.capability(c).label),
                          selected: _capabilities.contains(c),
                          onSelected: state.busy
                              ? null
                              : (on) => setState(() => on ? _capabilities.add(c) : _capabilities.remove(c)),
                        ),
                    ],
                  ),
                ),
                Text(
                  'Marcados según lo que anunció el dispositivo. El lector RFID solo aparece si respondió al encender.',
                  style: textTheme.bodySmall,
                ),
                if (state.error != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  ErrorView(message: state.error!),
                ],
                const SizedBox(height: AppSpacing.lg),
                FilledButton.icon(
                  onPressed: state.busy
                      ? null
                      : () => cubit.adopt(
                            name: _name.text,
                            location: _location.text,
                            capabilities: [for (final c in _allCapabilities) if (_capabilities.contains(c)) c],
                            unlockSeconds: _unlockSeconds,
                          ),
                  icon: state.action == AdoptAction.adopting
                      ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.add_task_outlined),
                  label: Text(state.action == AdoptAction.adopting ? 'Adoptando…' : 'Adoptar'),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: state.busy ? null : () => _confirmIgnore(context, cubit),
                  child: const Text('No es de este edificio: ignorar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _confirmIgnore(BuildContext context, IotAdoptCubit cubit) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('¿Ignorar el dispositivo?'),
        content: Text('${widget.args.discovered.deviceCode} dejará de aparecer como nuevo y seguirá sin poder operar.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('Ignorar')),
        ],
      ),
    );
    if (confirmed == true) await cubit.ignore();
  }
}

/// Código que muestra la pantalla del nodo: confirma que es la placa que tienes delante.
class _PairingCodeCard extends StatelessWidget {
  const _PairingCodeCard({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      tone: AppCardTone.highlighted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Comprueba el código en la pantalla del dispositivo', style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Semantics(
            label: 'Código ${code.split('').join(' ')}',
            excludeSemantics: true,
            child: Text(code, style: textTheme.displaySmall?.copyWith(color: AppColors.primary, letterSpacing: 8)),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text('La pantalla muestra "Sin registrar" y este código. Si no coincide, no lo adoptes.',
              style: textTheme.bodySmall),
        ],
      ),
    );
  }
}
