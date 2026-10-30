import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/events/data_changes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/edifika_logo.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/domain/authenticated_user.dart';
import '../../auth/presentation/residence_gate.dart';
import '../../profile/presentation/account_sheet.dart';
import '../../reservations/presentation/reservation_labels.dart';
import '../../reservations/presentation/reservation_routes_args.dart';
import '../../residential/domain/residence.dart';
import 'home_cubit.dart';

/// Mockup 02 · Inicio.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResidenceGate(
      builder: (context, user, residence) => BlocProvider(
        create: (context) => HomeCubit(
          payments: context.read(),
          reservations: context.read(),
          notifications: context.read(),
          announcements: context.read(),
          dataChanges: context.read<DataChanges>().stream,
        )..load(userId: user.id, buildingId: residence.building.id, unitId: residence.unit?.id),
        child: _HomeView(user: user, residence: residence),
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({required this.user, required this.residence});

  final AuthenticatedUser user;
  final Residence residence;

  Future<void> _reload(BuildContext context) =>
      context.read<HomeCubit>().load(userId: user.id, buildingId: residence.building.id, unitId: residence.unit?.id);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _reload(context),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(AppSpacing.screen, AppSpacing.md, AppSpacing.screen, AppSpacing.xxl),
                children: [
                  Row(
                    children: [
                      const EdifikaLogo(),
                      const Spacer(),
                      _NotificationsBell(count: state.unreadNotifications),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(residence.location, style: textTheme.bodySmall),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Semantics(header: true, child: Text('Hola, ${user.fullName}', style: textTheme.headlineMedium)),
                            const SizedBox(height: AppSpacing.xs),
                            Text('${roleLabel(user.roles)} · ${Formatters.longDay(DateTime.now())}', style: textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      Semantics(
                        button: true,
                        label: 'Mi cuenta',
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () => showAccountSheet(context),
                          child: InitialsAvatar(user.fullName, radius: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  ...switch (state.status) {
                    LoadStatus.loading => [const LoadingView()],
                    LoadStatus.failure => [ErrorView(message: state.error ?? '', onRetry: () => _reload(context))],
                    LoadStatus.ready => _content(context, state),
                  },
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _content(BuildContext context, HomeState state) {
    final textTheme = Theme.of(context).textTheme;
    final next = state.nextReservation;
    return [
      AppCard(
        tone: AppCardTone.highlighted,
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mi deuda total', style: textTheme.labelMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(Formatters.money(state.debtTotal, state.currency), style: textTheme.displaySmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${Formatters.money(state.pendingTotal, state.currency)} pendiente · '
              '${Formatters.money(state.overdueTotal, state.currency)} vencida',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.xl,
              children: [
                _ArrowLink('Ver mis deudas', onTap: () => context.go('/account')),
                _ArrowLink('Ver mis pagos', onTap: () => context.go('/account/payments')),
              ],
            ),
          ],
        ),
      ),
      SectionHeader('Mi próxima reserva', actionLabel: 'Ver todas', onAction: () => context.go('/reservations')),
      if (next == null)
        const EmptyView(message: 'No tienes reservas próximas.', icon: Icons.event_available_outlined)
      else
        AppCard(
          onTap: () => context.go(
            '/reservations/detail',
            extra: ReservationDetailArgs(block: next, areaName: state.nextReservationArea ?? 'Área común'),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.event_outlined, color: AppColors.primary),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: Text(state.nextReservationArea ?? 'Área común', style: textTheme.titleMedium)),
                  StatusChip(
                    reservationStatus(next, DateTime.now()).$1,
                    tone: reservationStatus(next, DateTime.now()).$2,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                '${Formatters.date(next.date)} · ${Formatters.hourRange(next.fromHour, next.toHour)}',
                style: textTheme.bodyMedium,
              ),
              Text(residence.location, style: textTheme.bodySmall),
            ],
          ),
        ),
      const SizedBox(height: AppSpacing.lg),
      AppCard(
        tone: AppCardTone.highlighted,
        onTap: () => context.go('/home/notifications'),
        child: Row(
          children: [
            const Icon(Icons.notifications_none, color: AppColors.primary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                state.unreadNotifications == 1
                    ? '1 notificación no leída'
                    : '${state.unreadNotifications} notificaciones no leídas',
                style: textTheme.labelMedium,
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
          ],
        ),
      ),
      SectionHeader('En tu edificio', actionLabel: 'Anuncios', onAction: () => context.go('/announcements')),
      if (state.announcementsUnavailable)
        const PendingIntegrationCard(
          title: 'Anuncios',
          message: 'Los comunicados del edificio aparecerán aquí cuando el servicio esté disponible.',
        )
      else if (state.latestAnnouncement == null)
        const EmptyView(message: 'No hay anuncios recientes.', icon: Icons.campaign_outlined)
      else
        AppCard(
          onTap: () => context.go('/announcements'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.latestAnnouncement!.priority.toUpperCase(),
                style: textTheme.labelSmall?.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(state.latestAnnouncement!.title, style: textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(state.latestAnnouncement!.description, style: textTheme.bodyMedium),
            ],
          ),
        ),
      const SizedBox(height: AppSpacing.xxl),
      OutlinedButton.icon(
        onPressed: () => context.go('/community'),
        icon: const Icon(Icons.forum_outlined),
        label: const Text('Explorar comunidades'),
      ),
    ];
  }
}

class _NotificationsBell extends StatelessWidget {
  const _NotificationsBell({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Notificaciones, $count sin leer',
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.button),
        onTap: () => context.go('/home/notifications'),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              const Icon(Icons.notifications_none, color: AppColors.primary),
              if (count > 0) ...[
                const SizedBox(width: AppSpacing.sm),
                StatusChip('$count', tone: StatusTone.pending),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ArrowLink extends StatelessWidget {
  const _ArrowLink(this.label, {required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(48, 40)),
      onPressed: onTap,
      child: Text('$label →'),
    );
  }
}
