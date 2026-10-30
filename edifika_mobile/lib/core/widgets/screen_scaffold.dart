import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// Encabezado de pantalla secundaria: flecha atrás + título + ubicación
/// ("Edificio · Departamento"), como en los mockups 03–12.
class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    super.key,
    required this.title,
    required this.body,
    this.location,
    this.showBack = true,
    this.onRefresh,
  });

  final String title;
  final String? location;
  final bool showBack;
  final Widget body;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final content = CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.screen, AppSpacing.sm, AppSpacing.screen, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (showBack && Navigator.of(context).canPop())
                      IconButton(
                        tooltip: 'Volver',
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(Icons.arrow_back),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                    if (showBack && Navigator.of(context).canPop()) const SizedBox(width: AppSpacing.sm),
                    Expanded(child: Semantics(header: true, child: Text(title, style: textTheme.headlineSmall))),
                  ],
                ),
                if (location != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(location!, style: textTheme.bodySmall),
                ],
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.screen, 0, AppSpacing.screen, AppSpacing.xxl),
          sliver: SliverToBoxAdapter(child: body),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: onRefresh == null ? content : RefreshIndicator(onRefresh: onRefresh!, child: content),
      ),
    );
  }
}

/// Título de sección con acción opcional a la derecha ("Ver todas").
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.actionLabel, this.onAction});

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl, bottom: AppSpacing.md),
      child: Row(
        children: [
          Expanded(child: Semantics(header: true, child: Text(title, style: Theme.of(context).textTheme.titleLarge))),
          if (actionLabel != null) TextButton(onPressed: onAction, child: Text(actionLabel!)),
        ],
      ),
    );
  }
}

/// Etiqueta en negrita sobre un campo de formulario.
class LabeledField extends StatelessWidget {
  const LabeledField({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );
  }
}
