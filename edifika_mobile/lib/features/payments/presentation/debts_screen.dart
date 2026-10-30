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
import '../../residential/domain/residence.dart';
import '../domain/payment_models.dart';
import 'account_cubits.dart';

/// Mockup 03 · Mis deudas (pestaña Cuenta).
class DebtsScreen extends StatelessWidget {
  const DebtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResidenceGate(
      builder: (context, user, residence) => BlocProvider(
        create: (context) => DebtsCubit(context.read())..load(residence.unit?.id),
        child: _DebtsView(residence: residence),
      ),
    );
  }
}

class _DebtsView extends StatelessWidget {
  const _DebtsView({required this.residence});

  final Residence residence;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<DebtsCubit>();
    final unitLabel = residence.unit == null ? '' : ' · Departamento ${residence.unit!.unitNumber}';

    return ScreenScaffold(
      title: 'Mis deudas',
      location: residence.location,
      onRefresh: () => cubit.load(residence.unit?.id),
      body: BlocBuilder<DebtsCubit, DebtsState>(
        builder: (context, state) {
          return switch (state.status) {
            LoadStatus.loading => const LoadingView(),
            LoadStatus.failure => ErrorView(message: state.error ?? '', onRetry: () => cubit.load(residence.unit?.id)),
            LoadStatus.ready => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppCard(
                    tone: AppCardTone.highlighted,
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total por pagar$unitLabel', style: textTheme.labelMedium),
                        const SizedBox(height: AppSpacing.sm),
                        Text(Formatters.money(state.total, state.currency), style: textTheme.displaySmall),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          state.debts.isEmpty
                              ? 'Estás al día. Solo se muestran las deudas de tu departamento.'
                              : '${state.debts.length} ${state.debts.length == 1 ? 'concepto' : 'conceptos'} sin pagar. '
                                  'Solo se muestran las deudas de tu departamento.',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SectionHeader('Detalle de mi deuda'),
                  if (state.debts.isEmpty)
                    const EmptyView(message: 'No tienes deudas pendientes.', icon: Icons.verified_outlined)
                  else
                    for (final debt in state.debts) ...[
                      _DebtCard(debt: debt),
                      const SizedBox(height: AppSpacing.md),
                    ],
                  const SizedBox(height: AppSpacing.md),
                  OutlinedButton.icon(
                    onPressed: () => context.go('/account/payments'),
                    icon: const Icon(Icons.receipt_long_outlined),
                    label: const Text('Ver mi historial de pagos'),
                  ),
                ],
              ),
          };
        },
      ),
    );
  }
}

class _DebtCard extends StatelessWidget {
  const _DebtCard({required this.debt});

  final Debt debt;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final overdue = debt.isOverdue(DateTime.now());
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  Formatters.money(debt.amount, debt.currency),
                  style: textTheme.headlineSmall,
                ),
              ),
              StatusChip(
                overdue ? 'Vencida' : 'Pendiente',
                tone: overdue ? StatusTone.danger : StatusTone.pending,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(debt.description, style: textTheme.bodyLarge),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(child: Text('Vencimiento', style: textTheme.bodyMedium)),
              Text(Formatters.date(debt.dueDate), style: textTheme.labelMedium),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            overdue ? 'La fecha de vencimiento ya pasó.' : 'Aún dentro del plazo de pago.',
            style: textTheme.bodySmall?.copyWith(color: overdue ? AppColors.error : null),
          ),
        ],
      ),
    );
  }
}
