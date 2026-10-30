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
import '../../auth/presentation/residence_gate.dart';
import '../domain/app_notification.dart';
import 'notifications_cubit.dart';

/// Mockup 08 · Notificaciones.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResidenceGate(
      builder: (context, user, residence) => BlocProvider(
        create: (context) => NotificationsCubit(context.read())..load(user.id),
        child: BlocConsumer<NotificationsCubit, NotificationsState>(
          listenWhen: (a, b) => b.message != null && a.message != b.message,
          listener: (context, state) =>
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!))),
          builder: (context, state) {
            final cubit = context.read<NotificationsCubit>();
            return ScreenScaffold(
              title: 'Notificaciones',
              location: residence.location,
              onRefresh: () => cubit.load(user.id),
              body: switch (state.status) {
                LoadStatus.loading => const LoadingView(),
                LoadStatus.failure => ErrorView(message: state.error ?? '', onRetry: () => cubit.load(user.id)),
                LoadStatus.ready => _NotificationsList(state: state),
              },
            );
          },
        ),
      ),
    );
  }
}

class _NotificationsList extends StatelessWidget {
  const _NotificationsList({required this.state});

  final NotificationsState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            StatusChip(state.unread == 1 ? '1 no leída' : '${state.unread} no leídas', tone: StatusTone.pending),
            const Spacer(),
            if (state.unread > 0) TextButton(onPressed: cubit.markAllRead, child: const Text('Marcar todas como leídas')),
          ],
        ),
        const SectionHeader('Últimas novedades'),
        if (state.items.isEmpty)
          const EmptyView(message: 'No tienes notificaciones.', icon: Icons.notifications_none)
        else
          for (final n in state.items) ...[
            _NotificationCard(notification: n, onOpen: () => cubit.markRead(n.id)),
            const SizedBox(height: AppSpacing.md),
          ],
      ],
    );
  }
}

/// La API no envía el tipo de notificación; se deduce del título para elegir
/// ícono y acción (solo presentación).
({IconData icon, String? action, String? route}) _kindOf(AppNotification n) {
  final text = '${n.title} ${n.content}'.toLowerCase();
  if (text.contains('reserva')) return (icon: Icons.event_available_outlined, action: 'Ver mis reservas', route: '/reservations');
  if (text.contains('pago')) return (icon: Icons.receipt_long_outlined, action: 'Ver mis pagos', route: '/account/payments');
  if (text.contains('deuda')) return (icon: Icons.account_balance_wallet_outlined, action: 'Ver mis deudas', route: '/account');
  if (text.contains('anuncio') || text.contains('comunicado')) {
    return (icon: Icons.campaign_outlined, action: 'Leer anuncio', route: '/announcements');
  }
  return (icon: Icons.notifications_none, action: null, route: null);
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification, required this.onOpen});

  final AppNotification notification;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final kind = _kindOf(notification);
    final unread = !notification.read;
    return AppCard(
      tone: unread ? AppCardTone.highlighted : AppCardTone.plain,
      onTap: unread ? onOpen : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(kind.icon, color: AppColors.primary),
              const Spacer(),
              StatusChip(unread ? 'No leída' : 'Leída', tone: unread ? StatusTone.pending : StatusTone.neutral),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(notification.title, style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(Formatters.dateTime(notification.createdAt), style: textTheme.bodySmall),
          const SizedBox(height: AppSpacing.md),
          Text(notification.content, style: textTheme.bodyLarge?.copyWith(fontSize: 15)),
          if (kind.route != null) ...[
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                if (unread) onOpen();
                context.go(kind.route!);
              },
              child: Text('${kind.action} →'),
            ),
          ],
        ],
      ),
    );
  }
}
