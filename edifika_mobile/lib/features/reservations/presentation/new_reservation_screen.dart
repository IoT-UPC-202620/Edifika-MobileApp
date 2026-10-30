import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/presentation/residence_gate.dart';
import '../domain/reservation_models.dart';
import 'new_reservation_cubit.dart';
import 'reservation_routes_args.dart';

/// Mockup 06 · Nueva reserva.
class NewReservationScreen extends StatelessWidget {
  const NewReservationScreen({super.key, required this.args});

  final NewReservationArgs args;

  @override
  Widget build(BuildContext context) {
    return ResidenceGate(
      builder: (context, user, residence) => BlocProvider(
        create: (context) {
          final cubit = NewReservationCubit(
            context.read(),
            areas: args.areas,
            reservations: args.reservations,
            residentId: user.id,
          );
          if (args.initialAreaId != null) cubit.selectArea(args.initialAreaId);
          return cubit;
        },
        child: BlocListener<NewReservationCubit, NewReservationState>(
          listenWhen: (a, b) => a.created == null && b.created != null,
          // `replace` conserva la pila de la pestaña: al cerrar la confirmación
          // se vuelve a la lista de reservas.
          listener: (context, state) => context.replace(
            '/reservations/detail',
            extra: ReservationDetailArgs(
              block: state.created!,
              areaName: state.area?.name ?? 'Área común',
              area: state.area,
              justCreated: true,
            ),
          ),
          child: ScreenScaffold(
            title: 'Nueva reserva',
            location: residence.location,
            body: _NewReservationForm(residentName: user.fullName),
          ),
        ),
      ),
    );
  }
}

class _NewReservationForm extends StatelessWidget {
  const _NewReservationForm({required this.residentName});

  final String residentName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<NewReservationCubit>();
    return BlocBuilder<NewReservationCubit, NewReservationState>(
      builder: (context, state) {
        final area = state.area;
        final validation = state.validationError(DateTime.now());
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Elige el espacio y el horario. La reserva quedará a nombre de $residentName.',
              style: textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.xl),
            LabeledField(
              label: 'Área común',
              child: DropdownButtonFormField<int>(
                initialValue: state.areaId,
                isExpanded: true,
                items: [
                  for (final a in state.areas)
                    DropdownMenuItem(
                      value: a.id,
                      enabled: a.isAvailable,
                      child: Text(a.isAvailable ? a.name : '${a.name} (en mantenimiento)'),
                    ),
                ],
                onChanged: cubit.selectArea,
              ),
            ),
            LabeledField(
              label: 'Fecha',
              child: _TapField(
                text: Formatters.dateWithWeekday(state.date),
                icon: Icons.calendar_today_outlined,
                semanticsLabel: 'Fecha, ${Formatters.dateWithWeekday(state.date)}. Toca para cambiar',
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: state.date,
                    firstDate: DateTime(now.year, now.month, now.day),
                    lastDate: now.add(const Duration(days: 90)),
                  );
                  if (picked != null) cubit.selectDate(picked);
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: LabeledField(
                    label: 'Desde',
                    child: _HourDropdown(
                      value: state.fromHour,
                      hours: [for (var h = firstBookableHour; h < lastBookableHour; h++) h],
                      taken: state.takenHours,
                      onChanged: cubit.selectFrom,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: LabeledField(
                    label: 'Hasta',
                    child: _HourDropdown(
                      value: state.toHour,
                      hours: [for (var h = state.fromHour + 1; h <= lastBookableHour; h++) h],
                      onChanged: cubit.selectTo,
                    ),
                  ),
                ),
              ],
            ),
            LabeledField(
              label: 'Número de asistentes',
              child: _GuestsStepper(
                value: state.guests,
                max: area?.maxCapacity ?? 0,
                onChanged: cubit.setGuests,
              ),
            ),
            if (validation == null)
              InfoBanner(
                success: true,
                title: 'Horario disponible',
                message: '${Formatters.date(state.apiDate)} · ${Formatters.hourRange(state.fromHour, state.toHour)} · '
                    '${state.hours.length} ${state.hours.length == 1 ? 'hora' : 'horas'}',
              )
            else
              _ProblemBanner(message: validation),
            if (area != null) ...[
              const SizedBox(height: AppSpacing.lg),
              _RulesCard(area: area),
            ],
            const SizedBox(height: AppSpacing.md),
            CheckboxListTile(
              value: state.acceptedRules,
              onChanged: (value) => cubit.acceptRules(value ?? false),
              title: Text('He leído y acepto las reglas del área común.', style: textTheme.bodyMedium?.copyWith(color: AppColors.onSurface)),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            if (state.error != null) ...[
              const SizedBox(height: AppSpacing.sm),
              _ProblemBanner(message: state.error!),
            ],
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: state.submitting ? null : cubit.submit,
              icon: state.submitting
                  ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.check),
              label: Text(state.submitting ? 'Reservando…' : 'Confirmar reserva'),
            ),
          ],
        );
      },
    );
  }
}

class _TapField extends StatelessWidget {
  const _TapField({required this.text, required this.icon, required this.onTap, required this.semanticsLabel});

  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.button),
        child: InputDecorator(
          decoration: InputDecoration(suffixIcon: Icon(icon)),
          child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
    );
  }
}

class _HourDropdown extends StatelessWidget {
  const _HourDropdown({required this.value, required this.hours, required this.onChanged, this.taken = const {}});

  final int value;
  final List<int> hours;
  final Set<int> taken;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      key: ValueKey('$value-${hours.first}'),
      initialValue: hours.contains(value) ? value : null,
      isExpanded: true,
      icon: const Icon(Icons.schedule),
      items: [
        for (final h in hours)
          DropdownMenuItem(
            value: h,
            child: Text(taken.contains(h) ? '${Formatters.hour(h)} · ocupado' : Formatters.hour(h)),
          ),
      ],
      onChanged: (h) {
        if (h != null) onChanged(h);
      },
    );
  }
}

class _GuestsStepper extends StatelessWidget {
  const _GuestsStepper({required this.value, required this.max, required this.onChanged});

  final int value;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4)),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Quitar asistente',
            onPressed: value > 1 ? () => onChanged(value - 1) : null,
            icon: const Icon(Icons.remove),
          ),
          Expanded(
            child: Text(
              '$value ${value == 1 ? 'asistente' : 'asistentes'}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          IconButton(
            tooltip: 'Agregar asistente',
            onPressed: max == 0 || value < max ? () => onChanged(value + 1) : null,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class _ProblemBanner extends StatelessWidget {
  const _ProblemBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(color: AppColors.errorContainer, borderRadius: BorderRadius.circular(AppRadius.card)),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: AppColors.error),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Text(message, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.error))),
          ],
        ),
      ),
    );
  }
}

class _RulesCard extends StatelessWidget {
  const _RulesCard({required this.area});

  final CommonArea area;

  List<String> get _rules {
    final rules = area.rules;
    return [
      if (area.maxCapacity > 0) 'Máximo ${area.maxCapacity} asistentes por reserva.',
      if (rules != null && rules.maxReservationHours > 0)
        'Hasta ${rules.maxReservationHours} ${rules.maxReservationHours == 1 ? 'hora' : 'horas'} por reserva.',
      if (rules != null && rules.requiresPayment && rules.price > 0) 'Costo: ${Formatters.money(rules.price)} por reserva.',
      if (rules != null && rules.requiresGuarantee) 'Garantía de ${Formatters.money(rules.guaranteeAmount)}.',
      if (rules != null && rules.allowCancellation && rules.penaltyHoursBefore > 0)
        'Cancela con al menos ${rules.penaltyHoursBefore} h de anticipación'
            '${rules.penaltyAmount > 0 ? ' para evitar una penalidad de ${Formatters.money(rules.penaltyAmount)}' : ''}.',
      if (rules != null && !rules.allowCancellation) 'Esta área no permite cancelar reservas.',
      if (rules != null && rules.requiresApproval) 'La reserva requiere aprobación de la administración.',
      'Deja el área limpia y respeta el horario.',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reglas de ${area.name}', style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          for (final rule in _rules)
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text('• $rule', style: textTheme.bodyMedium),
            ),
          const SizedBox(height: AppSpacing.md),
          const StatusChip('Uso exclusivo de residentes e invitados', tone: StatusTone.pending),
        ],
      ),
    );
  }
}
