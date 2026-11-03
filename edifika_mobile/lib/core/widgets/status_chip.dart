import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

enum StatusTone { success, pending, danger, neutral }

/// Chip de estado. El estado siempre va en texto, no solo en color.
class StatusChip extends StatelessWidget {
  const StatusChip(this.label, {super.key, this.tone = StatusTone.neutral, this.onTinted = false});

  final String label;
  final StatusTone tone;

  /// Sobre una tarjeta `highlighted` (violeta claro) los tonos neutral y
  /// pending usan fondo blanco para no confundirse con la tarjeta.
  final bool onTinted;

  @override
  Widget build(BuildContext context) {
    final tinted = onTinted ? AppColors.surface : AppColors.primaryContainer;
    final (background, foreground) = switch (tone) {
      StatusTone.success => (AppColors.successContainer, AppColors.success),
      StatusTone.pending => (tinted, AppColors.primary),
      StatusTone.danger => (AppColors.errorContainer, AppColors.error),
      StatusTone.neutral => (tinted, AppColors.onSurfaceVariant),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 3),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(AppRadius.chip)),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: foreground)),
    );
  }
}
