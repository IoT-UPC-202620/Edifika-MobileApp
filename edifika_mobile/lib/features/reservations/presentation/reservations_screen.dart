import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/events/data_changes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/presentation/residence_gate.dart';
import '../../residential/domain/residence.dart';
import '../domain/reservation_block.dart';
import '../domain/reservation_models.dart';
import 'reservation_labels.dart';
import 'reservation_routes_args.dart';
import 'reservations_cubit.dart';

/// Mockup 05 · Reservas.
class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResidenceGate(
      builder: (context, user, residence) => BlocProvider(
        create: (context) =>
            ReservationsCubit(context.read(), dataChanges: context.read<DataChanges>().stream)..load(user.id),
        child: _ReservationsView(userId: user.id, residence: residence),
      ),
    );
  }
}

class _ReservationsView extends StatelessWidget {
  const _ReservationsView({required this.userId, required this.residence});

  final int userId;
  final Residence residence;

  // La lista se recarga sola al crear o cancelar (DataChanges).
  void _openNew(BuildContext context, ReservationsState state, {int? areaId}) => context.push<void>(
        '/reservations/new',
        extra: NewReservationArgs(areas: state.areas, reservations: state.allReservations, initialAreaId: areaId),
      );

  void _openDetail(BuildContext context, ReservationsState state, ReservationBlock block) => context.push<void>(
        '/reservations/detail',
        extra: ReservationDetailArgs(
          block: block,
          areaName: state.areaName(block.commonAreaId),
          area: state.areas.where((a) => a.id == block.commonAreaId).firstOrNull,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<ReservationsCubit>();
    return ScreenScaffold(
      title: 'Reservas',
      location: residence.location,
      showBack: false,
      onRefresh: () => cubit.load(userId),
      body: BlocBuilder<ReservationsCubit, ReservationsState>(
        builder: (context, state) {
          if (state.status == LoadStatus.loading) return const LoadingView();
          if (state.status == LoadStatus.failure) {
            return ErrorView(message: state.error ?? '', onRetry: () => cubit.load(userId));
          }
          final now = DateTime.now();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Disfruta los espacios de ${residence.building.name}. Reserva un horario para tu departamento.',
                style: textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton.icon(
                onPressed: state.areas.isEmpty ? null : () => _openNew(context, state),
                icon: const Icon(Icons.add),
                label: const Text('Nueva reserva'),
              ),
              const SectionHeader('Áreas disponibles'),
              if (state.areas.isEmpty)
                const EmptyView(message: 'Tu edificio aún no tiene áreas comunes registradas.')
              else
                _AreasGrid(areas: state.areas, onTap: (area) => _openNew(context, state, areaId: area.id)),
              const SectionHeader('Mis próximas reservas'),
              if (state.upcoming.isEmpty)
                const EmptyView(message: 'No tienes reservas próximas.', icon: Icons.event_available_outlined)
              else
                for (final block in state.upcoming) ...[
                  _ReservationCard(
                    block: block,
                    areaName: state.areaName(block.commonAreaId),
                    residence: residence,
                    now: now,
                    highlighted: true,
                    onTap: () => _openDetail(context, state, block),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              const SectionHeader('Mis reservas pasadas'),
              if (state.past.isEmpty)
                const EmptyView(message: 'Aún no tienes reservas pasadas.', icon: Icons.history)
              else
                for (final block in state.past) ...[
                  _ReservationCard(
                    block: block,
                    areaName: state.areaName(block.commonAreaId),
                    residence: residence,
                    now: now,
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
            ],
          );
        },
      ),
    );
  }
}

class _AreasGrid extends StatelessWidget {
  const _AreasGrid({required this.areas, required this.onTap});

  final List<CommonArea> areas;
  final ValueChanged<CommonArea> onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - AppSpacing.md) / 2;
        return Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            for (final area in areas)
              SizedBox(
                width: width,
                child: AppCard(
                  onTap: area.isAvailable ? () => onTap(area) : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(areaIcon(area.type), color: AppColors.primary),
                      const SizedBox(height: AppSpacing.md),
                      Text(area.name, style: textTheme.bodyLarge, maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        area.maxCapacity > 0 ? 'Hasta ${area.maxCapacity} personas' : 'Turnos de 1 hora',
                        style: textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        area.isAvailable ? 'Disponible' : 'En mantenimiento',
                        style: textTheme.labelSmall?.copyWith(
                          color: area.isAvailable ? AppColors.success : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ReservationCard extends StatelessWidget {
  const _ReservationCard({
    required this.block,
    required this.areaName,
    required this.residence,
    required this.now,
    this.highlighted = false,
    this.onTap,
  });

  final ReservationBlock block;
  final String areaName;
  final Residence residence;
  final DateTime now;
  final bool highlighted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final (label, tone) = reservationStatus(block, now);
    final unit = residence.unit == null ? '' : 'Departamento ${residence.unit!.unitNumber} · ';
    return AppCard(
      tone: highlighted ? AppCardTone.highlighted : AppCardTone.plain,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(areaName, style: textTheme.titleMedium)),
              StatusChip(label, tone: tone),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${Formatters.date(block.date)} · ${Formatters.hourRange(block.fromHour, block.toHour)}',
            style: textTheme.bodyLarge,
          ),
          if (highlighted) ...[
            const SizedBox(height: AppSpacing.sm),
            Text('$unit${block.code}', style: textTheme.bodySmall),
            const SizedBox(height: AppSpacing.md),
            Text('Ver detalle de la reserva →', style: textTheme.labelMedium?.copyWith(color: AppColors.primary)),
          ],
        ],
      ),
    );
  }
}
