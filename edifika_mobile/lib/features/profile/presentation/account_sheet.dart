import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../auth/presentation/session_cubit.dart';

/// Figma no diseña una pantalla de perfil; esta hoja mínima muestra los datos
/// de la cuenta y permite cerrar sesión.
Future<void> showAccountSheet(BuildContext context) {
  final session = context.read<SessionCubit>();
  final user = session.state.user;
  final residence = session.state.residence;
  if (user == null) return Future.value();

  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) {
      final textTheme = Theme.of(sheetContext).textTheme;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.screen, 0, AppSpacing.screen, AppSpacing.screen),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InitialsAvatar(user.fullName, radius: 24),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.fullName, style: textTheme.titleMedium),
                        Text(user.email, style: textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('${roleLabel(user.roles)} · ${residence?.location ?? ''}', style: textTheme.bodyMedium),
              const SizedBox(height: AppSpacing.xxl),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  session.signOut();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

String roleLabel(List<String> roles) {
  final upper = roles.map((r) => r.toUpperCase()).toSet();
  if (upper.contains('OWNER')) return 'Propietario';
  if (upper.contains('TENANT')) return 'Inquilino';
  return 'Residente';
}
