import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/presentation/residence_gate.dart';
import '../domain/reservations_repository.dart';
import 'reservation_labels.dart';
import 'reservation_routes_args.dart';

/// Mockup 07 · Reserva confirmada. También sirve como detalle de una reserva,
/// con la opción de cancelarla.
class ReservationDetailScreen extends StatefulWidget {
  const ReservationDetailScreen({super.key, required this.args});

  final ReservationDetailArgs args;

  @override
  State<ReservationDetailScreen> createState() => _ReservationDetailScreenState();
}

class _ReservationDetailScreenState extends State<ReservationDetailScreen> {
  bool _cancelling = false;

  Future<void> _cancel() async {
    final rules = widget.args.area?.rules;
    final block = widget.args.block;
    final hoursLeft = block.start.difference(DateTime.now()).inHours;
    final penalty = rules != null && rules.penaltyAmount > 0 && hoursLeft < rules.penaltyHoursBefore;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Cancelar la reserva?'),
        content: Text(
          penalty
              ? 'Faltan menos de ${rules.penaltyHoursBefore} h. Podría aplicarse una penalidad de '
                  '${Formatters.money(rules.penaltyAmount)}.'
              : 'Se liberará el horario ${Formatters.hourRange(block.fromHour, block.toHour)} para otros vecinos.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Volver')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Cancelar reserva')),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _cancelling = true);
    final repository = context.read<ReservationsRepository>();
    final messenger = ScaffoldMessenger.of(context);
    try {
      for (final id in block.ids) {
        await repository.cancelReservation(id);
      }
      messenger.showSnackBar(const SnackBar(content: Text('Reserva cancelada.')));
      if (mounted) context.pop();
    } on ApiException catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(error.message)));
      if (mounted) setState(() => _cancelling = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = widget.args;
    final block = args.block;
    final textTheme = Theme.of(context).textTheme;
    final (label, tone) = reservationStatus(block, DateTime.now());
    final canCancel = !args.justCreated && block.isUpcoming(DateTime.now()) && (args.area?.rules?.allowCancellation ?? true);

    return ResidenceGate(
      builder: (context, user, residence) => ScreenScaffold(
        title: args.justCreated ? 'Reserva confirmada' : 'Detalle de la reserva',
        location: residence.location,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (args.justCreated) ...[
              const SizedBox(height: AppSpacing.md),
              const Center(
                child: CircleAvatar(
                  radius: 38,
                  backgroundColor: AppColors.successContainer,
                  child: Icon(Icons.check_circle_outline, color: AppColors.success, size: 36),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Semantics(
                liveRegion: true,
                child: Text('¡Tu espacio está reservado!', textAlign: TextAlign.center, style: textTheme.headlineMedium),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${user.fullName.split(' ').first}, ya puedes planificar tu encuentro. Guardamos la reserva para tu departamento.',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
            AppCard(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(args.areaName, style: textTheme.headlineSmall)),
                      StatusChip(label, tone: tone),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _Row('Fecha', Formatters.date(block.date)),
                  _Row('Horario', Formatters.hourRange(block.fromHour, block.toHour)),
                  _Row('Asistentes', '${block.guests} ${block.guests == 1 ? 'persona' : 'personas'}'),
                  _Row('Residente', user.fullName),
                  if (residence.unit != null) _Row('Departamento', '${residence.unit!.unitNumber}'),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Reserva ${block.code}', style: textTheme.labelSmall?.copyWith(color: AppColors.primary)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            if (args.justCreated)
              Text(
                'Esta es una reserva futura. Puedes consultarla en Mis reservas.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: () => context.canPop() ? context.pop() : context.go('/reservations'),
              icon: const Icon(Icons.calendar_month_outlined),
              label: const Text('Volver a mis reservas'),
            ),
            if (canCancel) ...[
              const SizedBox(height: AppSpacing.md),
              OutlinedButton.icon(
                onPressed: _cancelling ? null : _cancel,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error),
                ),
                icon: const Icon(Icons.event_busy_outlined),
                label: Text(_cancelling ? 'Cancelando…' : 'Cancelar reserva'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Expanded(child: Text(label, style: textTheme.bodyMedium)),
          Flexible(child: Text(value, textAlign: TextAlign.end, style: textTheme.labelMedium)),
        ],
      ),
    );
  }
}
