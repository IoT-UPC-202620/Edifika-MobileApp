import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

enum AppCardTone { plain, highlighted }

/// Tarjeta base: blanca con borde (`plain`) o violeta claro (`highlighted`),
/// como las tarjetas de resumen de Figma.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.tone = AppCardTone.plain,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
  });

  final Widget child;
  final AppCardTone tone;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.card);
    return Material(
      color: tone == AppCardTone.highlighted ? AppColors.primaryContainer : AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: radius, side: const BorderSide(color: AppColors.outline)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
