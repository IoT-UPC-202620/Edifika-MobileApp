import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../domain/iot_models.dart';
import 'iot_cards_cubit.dart';
import 'iot_labels.dart';
import 'iot_routes_args.dart';

/// Tarjetas RFID del edificio: lista con titular y estado, cambio de estado y
/// acceso al registro de una tarjeta nueva en un lector.
class IotCardsScreen extends StatelessWidget {
  const IotCardsScreen({super.key, required this.args});

  final IotCardsArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IotCardsCubit(context.read(), buildingId: args.buildingId, profile: context.read())..load(),
      child: BlocConsumer<IotCardsCubit, IotCardsState>(
        listenWhen: (a, b) => b.message != null && a.message != b.message,
        listener: (context, state) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!))),
        builder: (context, state) {
          final cubit = context.read<IotCardsCubit>();
          return ScreenScaffold(
            title: 'Tarjetas RFID',
            location: args.buildingName,
            onRefresh: cubit.refresh,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _RegisterCard(args: args),
                const SectionHeader('Tarjetas registradas'),
                ...switch (state.status) {
                  LoadStatus.loading => [const LoadingView(message: 'Cargando tarjetas…')],
                  LoadStatus.failure => [ErrorView(message: state.error ?? '', onRetry: cubit.load)],
                  LoadStatus.ready => _list(context, state),
                },
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _list(BuildContext context, IotCardsState state) {
    if (state.credentials.isEmpty) {
      return const [
        EmptyView(
          message: 'Este edificio aún no tiene tarjetas. Registra la primera desde un lector.',
          icon: Icons.credit_card_off_outlined,
        ),
      ];
    }
    final cubit = context.read<IotCardsCubit>();
    final inactive = state.credentials.length - state.activeCount;
    final visible = state.visible;
    return [
      SegmentedButton<CardFilter>(
        segments: [
          ButtonSegment(value: CardFilter.all, label: Text('Todas (${state.credentials.length})')),
          ButtonSegment(value: CardFilter.active, label: Text('Activas (${state.activeCount})')),
          ButtonSegment(value: CardFilter.inactive, label: Text('Inactivas ($inactive)')),
        ],
        selected: {state.filter},
        showSelectedIcon: false,
        onSelectionChanged: (value) => cubit.setFilter(value.first),
      ),
      const SizedBox(height: AppSpacing.md),
      if (visible.isEmpty)
        const EmptyView(message: 'No hay tarjetas con este filtro.', icon: Icons.filter_alt_off_outlined)
      else
        for (final credential in visible) ...[
          _CredentialTile(credential: credential, state: state),
          const SizedBox(height: AppSpacing.md),
        ],
    ];
  }
}

/// Acceso al modo registro: se elige el lector donde se acercará la tarjeta.
class _RegisterCard extends StatelessWidget {
  const _RegisterCard({required this.args});

  final IotCardsArgs args;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final readers = args.readers;
    final online = readers.where((d) => d.status.toUpperCase() == 'ACTIVE').toList();

    return AppCard(
      tone: AppCardTone.highlighted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.contactless_outlined, color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Text('Registrar tarjeta nueva', style: textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            readers.isEmpty
                ? 'El edificio no tiene lectores RFID registrados.'
                : online.isEmpty
                    ? 'Ningún lector está en línea. Enciende el lector para registrar tarjetas.'
                    : 'Elige el lector, acerca la tarjeta y asígnala a un usuario. La puerta no se abre durante el registro.',
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: online.isEmpty ? null : () => _chooseReader(context, online),
              icon: const Icon(Icons.add_card_outlined),
              label: const Text('Leer tarjeta en un lector'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _chooseReader(BuildContext context, List<IotDevice> online) async {
    final cubit = context.read<IotCardsCubit>();
    final reader = online.length == 1
        ? online.first
        : await showModalBottomSheet<IotDevice>(
            context: context,
            showDragHandle: true,
            builder: (sheetContext) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm),
                    child: Text('¿En qué lector acercarás la tarjeta?', style: Theme.of(sheetContext).textTheme.titleMedium),
                  ),
                  for (final d in online)
                    ListTile(
                      leading: Icon(IotLabels.deviceIcon(d.deviceType)),
                      title: Text(d.name),
                      subtitle: d.location.isEmpty ? null : Text(d.location),
                      onTap: () => Navigator.of(sheetContext).pop(d),
                    ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          );
    if (reader == null || !context.mounted) return;
    await context.push(
      '/admin/iot/device',
      extra: IotDeviceDetailArgs(device: reader, gateway: args.gatewayOf(reader), startEnrollment: true),
    );
    if (!cubit.isClosed) await cubit.refresh();
  }
}

class _CredentialTile extends StatelessWidget {
  const _CredentialTile({required this.credential, required this.state});

  final AccessCredential credential;
  final IotCardsState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final (label, tone) = IotLabels.credentialStatus(credential.status);
    final user = state.userOf(credential);
    final role = user == null ? null : IotLabels.userRole(user.roles);
    final busy = state.busyCredentialId == credential.id;
    final details = [if (user != null && user.email.isNotEmpty) user.email, ?role].join(' · ');

    return AppCard(
      onTap: busy ? null : () => _showActions(context),
      child: Row(
        children: [
          const Icon(Icons.credit_card, color: AppColors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.holderOf(credential), style: textTheme.titleMedium),
                if (details.isNotEmpty) Text(details, style: textTheme.bodySmall),
                const SizedBox(height: AppSpacing.xs),
                Text('UID ${credential.rfidUid}', style: textTheme.labelMedium),
                if (credential.updatedAt != null || credential.createdAt != null)
                  Text(
                    'Actualizada: ${Formatters.instant(credential.updatedAt ?? credential.createdAt)}',
                    style: textTheme.bodySmall,
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          if (busy)
            const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
          else
            StatusChip(label, tone: tone),
        ],
      ),
    );
  }

  Future<void> _showActions(BuildContext context) async {
    final cubit = context.read<IotCardsCubit>();
    final status = credential.status.toUpperCase();
    final actions = <(String, String, IconData)>[
      if (status == 'ACTIVE') ('SUSPENDED', 'Suspender', Icons.pause_circle_outline),
      if (status != 'ACTIVE') ('ACTIVE', 'Reactivar', Icons.play_circle_outline),
      if (status != 'LOST') ('LOST', 'Marcar como perdida', Icons.report_gmailerrorred_outlined),
      if (status != 'REVOKED') ('REVOKED', 'Revocar', Icons.block),
    ];
    final chosen = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xs),
              child: Text(state.holderOf(credential), style: Theme.of(sheetContext).textTheme.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm),
              child: Text(
                'UID ${credential.rfidUid}. Una tarjeta revocada o perdida se puede volver a registrar para otro usuario.',
                style: Theme.of(sheetContext).textTheme.bodySmall,
              ),
            ),
            for (final (value, label, icon) in actions)
              ListTile(leading: Icon(icon), title: Text(label), onTap: () => Navigator.of(sheetContext).pop(value)),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
    if (chosen == null || !context.mounted) return;
    if (chosen == 'REVOKED' || chosen == 'LOST') {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(chosen == 'REVOKED' ? '¿Revocar la tarjeta?' : '¿Marcar como perdida?'),
          content: Text('${state.holderOf(credential)} ya no podrá abrir la puerta con la tarjeta ${credential.rfidUid}.'),
          actions: [
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('Confirmar')),
          ],
        ),
      );
      if (confirmed != true) return;
    }
    await cubit.changeStatus(credential, chosen);
  }
}
