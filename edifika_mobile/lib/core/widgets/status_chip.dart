import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

enum StatusTone { success, pending, danger, neutral }

/// Chip de estado. El estado siempre va en texto, no solo en color.
class StatusChip extends StatelessWidget {
  const StatusChip(this.label, {super.key, this.tone = StatusTone.neutral});

  final String label;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (tone) {
      StatusTone.success => (AppColors.successContainer, AppColors.success),
      StatusTone.pending => (AppColors.primaryContainer, AppColors.primary),
      StatusTone.danger => (AppColors.errorContainer, AppColors.error),
      StatusTone.neutral => (AppColors.primaryContainer, AppColors.onSurfaceVariant),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 3),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(AppRadius.chip)),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: foreground)),
    );
  }
}
