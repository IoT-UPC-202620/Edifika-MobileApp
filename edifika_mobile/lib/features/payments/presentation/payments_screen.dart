import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/presentation/residence_gate.dart';
import '../domain/payment_models.dart';
import 'account_cubits.dart';

/// Mockup 04 · Mis pagos.
class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResidenceGate(
      builder: (context, user, residence) {
        return BlocProvider(
          create: (context) => PaymentsCubit(context.read())..load(userId: user.id, unitId: residence.unit?.id),
          child: Builder(
            builder: (context) {
              final cubit = context.read<PaymentsCubit>();
              Future<void> reload() => cubit.load(userId: user.id, unitId: residence.unit?.id);
              return ScreenScaffold(
                title: 'Mis pagos',
                location: residence.location,
                onRefresh: reload,
                body: BlocBuilder<PaymentsCubit, PaymentsState>(
                  builder: (context, state) => switch (state.status) {
                    LoadStatus.loading => const LoadingView(),
                    LoadStatus.failure => ErrorView(message: state.error ?? '', onRetry: reload),
                    LoadStatus.ready => _PaymentsContent(state: state),
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _PaymentsContent extends StatelessWidget {
  const _PaymentsContent({required this.state});

  final PaymentsState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final last = state.lastConfirmed;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Tu historial personal, siempre a mano. Consulta tus pagos registrados.',
          style: textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (last != null)
          AppCard(
            tone: AppCardTone.highlighted,
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Último pago confirmado', style: textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: Text(Formatters.money(last.amount, last.currency), style: textTheme.headlineMedium),
                    ),
                    const StatusChip('Confirmado', tone: StatusTone.success),
                  ],
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xxl, bottom: AppSpacing.md),
          child: Row(
            children: [
              Expanded(child: Semantics(header: true, child: Text('Historial', style: textTheme.titleLarge))),
              if (state.years.isNotEmpty)
                DropdownButton<int?>(
                  value: state.year,
                  underline: const SizedBox.shrink(),
                  style: textTheme.labelMedium?.copyWith(color: AppColors.primary),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Todos')),
                    for (final y in state.years) DropdownMenuItem(value: y, child: Text('$y')),
                  ],
                  onChanged: (value) => context.read<PaymentsCubit>().selectYear(value),
                ),
            ],
          ),
        ),
        if (state.visible.isEmpty)
          const EmptyView(message: 'No hay pagos registrados en este periodo.', icon: Icons.receipt_long_outlined)
        else
          for (final payment in state.visible) ...[
            _PaymentCard(payment: payment, concept: state.conceptOf(payment)),
            const SizedBox(height: AppSpacing.md),
          ],
        const SizedBox(height: AppSpacing.sm),
        Text(
          '${state.visible.length} ${state.visible.length == 1 ? 'pago' : 'pagos'} en el periodo seleccionado.',
          textAlign: TextAlign.center,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({required this.payment, required this.concept});

  final Payment payment;
  final String concept;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final confirmed = payment.status.toUpperCase() == 'PAID';
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(Formatters.date(payment.paymentDate), style: textTheme.bodyMedium)),
              Text(Formatters.money(payment.amount, payment.currency), style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(concept, style: textTheme.bodyLarge),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              StatusChip(
                confirmed ? 'Confirmado' : payment.status,
                tone: confirmed ? StatusTone.success : StatusTone.pending,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(_methodLabel(payment.paymentMethod), style: textTheme.bodySmall),
            ],
          ),
          const Divider(height: AppSpacing.xxl),
          // Comprobantes: el diseño los muestra, pero la fake API no los expone.
          Row(
            children: [
              const Icon(Icons.picture_as_pdf_outlined, size: 18, color: AppColors.onSurfaceVariant),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text('Comprobante · pendiente de integración', style: textTheme.bodySmall)),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text('P-${payment.paymentDate.replaceAll('-', '')}-${payment.id}', style: textTheme.bodySmall),
        ],
      ),
    );
  }

  static String _methodLabel(String method) => switch (method.toUpperCase()) {
        'YAPE' => 'Yape',
        'PLIN' => 'Plin',
        'TRANSFER' || 'BANK_TRANSFER' => 'Transferencia bancaria',
        'CARD' => 'Tarjeta',
        'CASH' => 'Efectivo',
        '' => 'Método no indicado',
        _ => method,
      };
}
