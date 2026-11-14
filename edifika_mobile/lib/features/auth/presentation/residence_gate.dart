import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../residential/domain/residence.dart';
import '../domain/authenticated_user.dart';
import 'session_cubit.dart';

/// Construye la pantalla solo cuando ya se conoce el edificio y la unidad del
/// residente; mientras tanto muestra carga o error con reintento.
class ResidenceGate extends StatelessWidget {
  const ResidenceGate({super.key, required this.builder});

  final Widget Function(BuildContext context, AuthenticatedUser user, Residence residence) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (a, b) => a.residence != b.residence || a.residenceError != b.residenceError || a.user != b.user,
      builder: (context, state) {
        final user = state.user;
        final residence = state.residence;
        if (user != null && residence != null) return builder(context, user, residence);

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.screen),
              child: state.residenceError != null
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ErrorView(
                            message: state.residenceError!,
                            onRetry: () => context.read<SessionCubit>().loadResidence(),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          OutlinedButton.icon(
                            onPressed: () => context.read<SessionCubit>().signOut(),
                            icon: const Icon(Icons.logout),
                            label: const Text('Cerrar sesión'),
                          ),
                        ],
                      ),
                    )
                  : const LoadingView(message: 'Cargando tu edificio…'),
            ),
          ),
        );
      },
    );
  }
}
