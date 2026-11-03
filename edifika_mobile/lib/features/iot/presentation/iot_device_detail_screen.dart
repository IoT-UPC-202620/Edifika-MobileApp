import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/live_refresh.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../domain/iot_models.dart';
import 'iot_device_control_cubit.dart';
import 'iot_labels.dart';
import 'iot_routes_args.dart';

/// Detalle de un dispositivo IoT con las acciones del administrador:
/// reservar la puerta a su nombre, cambiar el color del LED RGB y registrar
/// tarjetas RFID.
class IotDeviceDetailScreen extends StatelessWidget {
  const IotDeviceDetailScreen({super.key, required this.args});

  final IotDeviceDetailArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IotDeviceControlCubit(
        context.read(),
        profile: context.read(),
        residential: context.read(),
        device: args.device,
        telemetry: args.telemetry,
      )
        ..refreshLive()
        ..startAutoRefresh()
        ..startEnrollmentIf(args.startEnrollment),
      child: BlocConsumer<IotDeviceControlCubit, IotDeviceControlState>(
        listenWhen: (a, b) => b.message != null && a.message != b.message,
        listener: (context, state) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!))),
        builder: (context, state) {
          final cubit = context.read<IotDeviceControlCubit>();
          return PauseWhenInBackground(
            onPause: cubit.stopAutoRefresh,
            onResume: () => cubit
              ..refreshLive()
              ..startAutoRefresh(),
            child: _DetailBody(args: args, state: state),
          );
        },
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.args, required this.state});

  final IotDeviceDetailArgs args;
  final IotDeviceControlState state;

  @override
  Widget build(BuildContext context) {
    final device = state.device;
    final gateway = args.gateway;
    final telemetry = state.telemetry;
    final (statusLabel, statusTone) = IotLabels.deviceStatus(device.status);

    return ScreenScaffold(
      title: device.name,
      location: [IotLabels.deviceType(device.deviceType), if (device.location.isNotEmpty) device.location].join(' · '),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader('Acciones'),
          _ReserveCard(state: state),
          if (state.hasRgbLed) ...[
            const SizedBox(height: AppSpacing.md),
            _LedCard(state: state),
          ],
          if (state.hasRfid) ...[
            const SizedBox(height: AppSpacing.md),
            _EnrollCard(state: state),
          ],
          const SizedBox(height: AppSpacing.md),
          const InfoBanner(
            title: 'Próximamente',
            message: 'Abrir la puerta y activar el modo mantenimiento estarán disponibles en una próxima versión.',
          ),
          const SectionHeader('Estado'),
          _DetailCard(rows: [
            _Row('Estado', trailing: StatusChip(statusLabel, tone: statusTone)),
            _Row('Última conexión', value: Formatters.instant(device.lastSeenAt)),
            if (telemetry != null) _Row('Último heartbeat', value: Formatters.instant(telemetry.lastHeartbeatAt)),
            _Row('Firmware', value: device.firmwareVersion ?? 'Sin reportar'),
            _Row('Código', value: device.deviceCode),
            _Row('Registrado', value: Formatters.instant(device.createdAt, fallback: '—')),
          ]),
          const SectionHeader('Acceso'),
          _DetailCard(rows: [
            _Row('Modo', value: IotLabels.accessMode(device.accessMode)),
            if (device.activeReservationId != null) _Row('Reserva activa', value: '#${device.activeReservationId}'),
            _Row('Apertura', value: device.unlockSeconds == 1 ? '1 segundo' : '${device.unlockSeconds} segundos'),
            _Row('Color del LED', trailing: _LedColor(hex: device.ledColor)),
          ]),
          const SectionHeader('Sensores'),
          if (state.updatedAt != null) ...[
            Align(alignment: Alignment.centerRight, child: UpdatedAgo(at: state.updatedAt)),
            const SizedBox(height: AppSpacing.sm),
          ],
          if (telemetry == null)
            const EmptyView(message: 'Sin lecturas de telemetría para este dispositivo.', icon: Icons.sensors_off_outlined)
          else if (telemetry.latest.isEmpty)
            const EmptyView(message: 'El dispositivo aún no envió lecturas.', icon: Icons.sensors_off_outlined)
          else
            _DetailCard(rows: [
              for (final r in telemetry.latest)
                _Row(
                  IotLabels.magnitude(r.magnitude).label,
                  icon: IotLabels.magnitude(r.magnitude).icon,
                  value: IotLabels.reading(r.value, r.unit),
                  caption: Formatters.instant(r.capturedAt, fallback: ''),
                ),
            ]),
          const SectionHeader('Componentes'),
          if (device.capabilities.isEmpty)
            const EmptyView(message: 'El dispositivo no declara componentes.', icon: Icons.memory_outlined)
          else
            _DetailCard(rows: [
              for (final c in device.capabilities)
                _Row(IotLabels.capability(c).label, icon: IotLabels.capability(c).icon),
            ]),
          const SectionHeader('Conexión'),
          _DetailCard(rows: [
            _Row('Gateway', value: gateway?.name ?? device.gatewayCode),
            _Row('Código del gateway', value: gateway?.gatewayCode ?? device.gatewayCode),
            if (gateway != null)
              _Row('Estado del gateway', trailing: () {
                final (label, tone) = IotLabels.gatewayStatus(gateway.status);
                return StatusChip(label, tone: tone);
              }()),
          ]),
        ],
      ),
    );
  }
}

/// Modo registro de tarjetas RFID en el lector seleccionado.
class _EnrollCard extends StatelessWidget {
  const _EnrollCard({required this.state});

  final IotDeviceControlState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<IotDeviceControlCubit>();
    final enrollment = state.enrollment;
    final created = state.createdCredential;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.contactless_outlined, color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Text('Registrar tarjeta', style: textTheme.titleMedium)),
              if (state.isWaitingCard)
                StatusChip('${state.enrollmentSecondsLeft} s', tone: StatusTone.pending)
              else if (enrollment != null && enrollment.isCaptured)
                const StatusChip('Capturada', tone: StatusTone.success),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (state.isWaitingCard) ...[
            Semantics(
              liveRegion: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'Esperando tarjeta en el lector (${state.enrollmentSecondsLeft} s restantes)…',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Acerca la tarjeta RFID al lector. El LED se ilumina en cian y la puerta no se abrirá.',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: cubit.cancelEnrollment,
                icon: const Icon(Icons.close),
                label: const Text('Cancelar modo registro'),
              ),
            ),
          ] else if (enrollment != null && enrollment.isCaptured) ...[
            _CapturedCardView(state: state, enrollment: enrollment),
          ] else ...[
            if (enrollment != null && enrollment.isExpired) ...[
              const InfoBanner(
                title: 'Tiempo agotado',
                message: 'No se acercó ninguna tarjeta durante los 60 segundos.',
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            if (created != null) ...[
              InfoBanner(
                title: 'Tarjeta ${created.rfidUid} registrada',
                message: 'Asociada a ${created.holderName ?? 'residente'}.',
                success: true,
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            if (state.enrollmentError != null) ...[
              ErrorView(message: state.enrollmentError!),
              const SizedBox(height: AppSpacing.md),
            ],
            Text(
              state.isOnline
                  ? 'Activa el modo registro durante 60 segundos para capturar una tarjeta sin abrir la puerta y asociarla a un residente.'
                  : 'El lector debe estar en línea para iniciar el modo registro.',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: state.canStartEnrollment ? cubit.startEnrollment : null,
                icon: state.enrolling
                    ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.badge_outlined),
                label: Text(
                  state.enrolling
                      ? 'Activando modo registro…'
                      : created != null
                          ? 'Registrar otra tarjeta'
                          : 'Registrar tarjeta',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CapturedCardView extends StatelessWidget {
  const _CapturedCardView({required this.state, required this.enrollment});

  final IotDeviceControlState state;
  final CardEnrollment enrollment;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<IotDeviceControlCubit>();
    final uid = enrollment.capturedUid ?? '';
    final existing = enrollment.existingCredential;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Row(
            children: [
              const Icon(Icons.credit_card, color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('UID capturado', style: textTheme.bodySmall),
                    Text(uid, style: textTheme.titleMedium?.copyWith(color: AppColors.primary)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (existing != null && IotLabels.isRetiredCredential(existing.status)) ...[
          InfoBanner(
            title: 'Tarjeta dada de baja',
            message: 'Pertenecía a ${existing.holderName ?? 'otro usuario'} (${IotLabels.credentialStatus(existing.status ?? '').$1.toLowerCase()}). '
                'Al asociarla queda activa para el usuario que elijas.',
            icon: Icons.info_outline,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        if (existing != null && !IotLabels.isRetiredCredential(existing.status)) ...[
          InfoBanner(
            title: 'Esta tarjeta ya pertenece a ${existing.holderName ?? 'un residente'}',
            message: 'Estado actual: ${existing.status ?? 'ACTIVA'}. Usa otra tarjeta para registrar una nueva credencial.',
            icon: Icons.warning_amber_rounded,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: cubit.cancelEnrollment,
                  child: const Text('Cerrar'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: FilledButton.icon(
                  onPressed: state.canStartEnrollment ? cubit.startEnrollment : null,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Capturar otra'),
                ),
              ),
            ],
          ),
        ] else ...[
          if (state.loadingResidents)
            const _Progress('Cargando usuarios…')
          else if (state.residents.isEmpty)
            const EmptyView(
              message: 'No se encontraron usuarios para asociar la tarjeta.',
              icon: Icons.person_off_outlined,
            )
          else
            LabeledField(
              label: 'Asignar a',
              child: DropdownButtonFormField<int>(
                key: ValueKey(state.selectedResidentId),
                initialValue: state.selectedResidentId,
                isExpanded: true,
                items: [
                  for (final r in state.residents)
                    DropdownMenuItem(
                      value: r.id,
                      child: Text(
                        [r.fullName, if (r.email.isNotEmpty) r.email, ?IotLabels.userRole(r.roles)].join(' · '),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: state.creatingCredential
                    ? null
                    : (id) {
                        if (id != null) cubit.selectResident(id);
                      },
              ),
            ),
          if (state.enrollmentError != null) ...[
            ErrorView(message: state.enrollmentError!),
            const SizedBox(height: AppSpacing.md),
          ],
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: state.creatingCredential ? null : cubit.cancelEnrollment,
                  child: const Text('Cancelar'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: FilledButton.icon(
                  onPressed: state.canAssignCard ? cubit.assignCapturedCard : null,
                  icon: state.creatingCredential
                      ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.person_add_alt_1_outlined),
                  label: Text(state.creatingCredential ? 'Asociando…' : 'Asociar'),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// Reserva de la puerta a nombre del administrador, desde ahora.
class _ReserveCard extends StatefulWidget {
  const _ReserveCard({required this.state});

  final IotDeviceControlState state;

  @override
  State<_ReserveCard> createState() => _ReserveCardState();
}

class _ReserveCardState extends State<_ReserveCard> {
  static const _durations = [Duration(minutes: 10), Duration(minutes: 30), Duration(hours: 1)];
  Duration _selected = _durations.first;

  static String _label(Duration d) => d.inMinutes < 60 ? '${d.inMinutes} min' : '${d.inHours} h';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = widget.state;
    final reservation = state.reservation;
    final mine = reservation != null && context.read<IotDeviceControlCubit>().hasPendingReservation;
    final reservedByMe = mine && state.isReserved && state.device.activeReservationId == reservation.id;
    final activating = mine && !state.isReserved;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.event_available_outlined, color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Text('Reservar para mí', style: textTheme.titleMedium)),
              if (state.isReserved) const StatusChip('Reservada', tone: StatusTone.pending),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (reservedByMe)
            Text(
              'Reserva #${reservation.id} a tu nombre hasta las ${Formatters.instant(reservation.endsAt).split(' · ').last}.',
              style: textTheme.bodyMedium,
            )
          else if (activating)
            Semantics(
              liveRegion: true,
              child: Row(
                children: [
                  const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      'Reserva #${reservation.id} creada. Activándola en la puerta…',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            )
          else if (state.isReserved)
            Text('La puerta ya tiene una reserva activa.', style: textTheme.bodyMedium)
          else ...[
            Text('Reserva la puerta a tu nombre desde ahora. Duración:', style: textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.md),
            SegmentedButton<Duration>(
              segments: [for (final d in _durations) ButtonSegment(value: d, label: Text(_label(d)))],
              selected: {_selected},
              showSelectedIcon: false,
              onSelectionChanged: state.reserving ? null : (value) => setState(() => _selected = value.first),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: state.reserving ? null : () => context.read<IotDeviceControlCubit>().reserveForMe(_selected),
                icon: state.reserving
                    ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.lock_clock_outlined),
                label: Text(state.reserving ? 'Reservando…' : 'Reservar ${_label(_selected)}'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Colores disponibles para el LED RGB del nodo (nombre siempre visible).
const _ledPalette = [
  ('Amarillo', '#FFFF00'),
  ('Verde', '#00FF00'),
  ('Azul', '#0000FF'),
  ('Rojo', '#FF0000'),
  ('Violeta', '#800080'),
  ('Blanco', '#FFFFFF'),
];

class _LedCard extends StatelessWidget {
  const _LedCard({required this.state});

  final IotDeviceControlState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<IotDeviceControlCubit>();
    final current = state.device.ledColor?.toUpperCase();
    final colorName = _ledPalette.where((c) => c.$2 == state.requestedColor).map((c) => c.$1).firstOrNull ??
        state.requestedColor ?? '';

    final hint = !state.isOnline
        ? 'El dispositivo debe estar en línea para cambiar el color.'
        : !state.isReserved
            ? 'Disponible mientras la puerta está reservada (el LED solo se enciende en modo reservada).'
            : 'Elige un color: el dispositivo confirma el cambio.';

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Text('Color del LED', style: textTheme.titleMedium)),
              _LedColor(hex: state.device.ledColor),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(hint, style: textTheme.bodySmall),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final (name, hex) in _ledPalette)
                _ColorOption(
                  name: name,
                  hex: hex,
                  selected: current == hex,
                  onTap: state.canSetLed ? () => cubit.setLedColor(hex) : null,
                ),
            ],
          ),
          if (state.ledStatus != LedCommandStatus.idle) ...[
            const SizedBox(height: AppSpacing.md),
            switch (state.ledStatus) {
              LedCommandStatus.sending => _Progress('Enviando $colorName…'),
              LedCommandStatus.waiting => _Progress('Esperando confirmación del dispositivo…'),
              LedCommandStatus.applied => InfoBanner(title: 'Color aplicado: $colorName', success: true),
              LedCommandStatus.rejected => ErrorView(message: state.ledError ?? 'No se pudo cambiar el color.'),
              LedCommandStatus.idle => const SizedBox.shrink(),
            },
          ],
        ],
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Row(
        children: [
          const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  const _ColorOption({required this.name, required this.hex, required this.selected, required this.onTap});

  final String name;
  final String hex;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = Color(0xFF000000 | int.parse(hex.substring(1), radix: 16));
    return Semantics(
      button: true,
      selected: selected,
      enabled: onTap != null,
      label: 'Color $name',
      excludeSemantics: true,
      child: Opacity(
        opacity: onTap == null ? 0.45 : 1,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.button),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.button),
              border: Border.all(color: selected ? AppColors.primary : AppColors.outline, width: selected ? 2 : 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.outline),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(name, style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Row {
  const _Row(this.label, {this.value, this.trailing, this.icon, this.caption});

  final String label;
  final String? value;
  final Widget? trailing;
  final IconData? icon;
  final String? caption;
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.rows});

  final List<_Row> rows;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const Divider(height: AppSpacing.xxl, color: AppColors.outline),
            Row(
              children: [
                if (rows[i].icon != null) ...[
                  Icon(rows[i].icon, size: 20, color: AppColors.primary),
                  const SizedBox(width: AppSpacing.md),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rows[i].label, style: textTheme.bodyMedium),
                      if (rows[i].caption != null && rows[i].caption!.isNotEmpty)
                        Text(rows[i].caption!, style: textTheme.bodySmall),
                    ],
                  ),
                ),
                if (rows[i].value != null)
                  // tight: ocupa su mitad para que textAlign.end alinee a la derecha.
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(rows[i].value!, textAlign: TextAlign.end, style: textTheme.labelMedium),
                  ),
                ?rows[i].trailing,
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Muestra del color del LED con su código: el color nunca va solo.
class _LedColor extends StatelessWidget {
  const _LedColor({required this.hex});

  final String? hex;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelMedium;
    final value = hex == null ? null : int.tryParse(hex!.replaceFirst('#', ''), radix: 16);
    if (value == null) return Text('Apagado', style: style);
    final name = _ledPalette.where((c) => c.$2 == hex!.toUpperCase()).map((c) => c.$1).firstOrNull;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: Color(0xFF000000 | value),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.outline),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(name ?? hex!.toUpperCase(), style: style),
      ],
    );
  }
}
