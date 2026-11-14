import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/presentation/residence_gate.dart';
import '../../iot/presentation/iot_labels.dart';
import '../../residential/domain/residence.dart';
import '../data/access_repository.dart';
import '../domain/access_models.dart';

/// Mis accesos (OWNER y TENANT): puertas, tarjetas e intentos recientes.
/// Endpoints: /access/me/doors, /access/me/credentials, /access/me/attempts.
class MyAccessScreen extends StatelessWidget {
  const MyAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResidenceGate(
      builder: (context, user, residence) => _MyAccessView(residence: residence),
    );
  }
}

class _MyAccessData {
  const _MyAccessData(this.doors, this.credentials, this.attempts);

  final List<AccessDoor> doors;
  final List<MyCredential> credentials;
  final List<AccessAttempt> attempts;
}

class _MyAccessView extends StatefulWidget {
  const _MyAccessView({required this.residence});

  final Residence residence;

  @override
  State<_MyAccessView> createState() => _MyAccessViewState();
}

class _MyAccessViewState extends State<_MyAccessView> {
  late Future<_MyAccessData> _future = _load();

  Future<_MyAccessData> _load() async {
    final repository = context.read<AccessRepository>();
    final results = await Future.wait([
      repository.myDoors(),
      repository.myCredentials(),
      repository.myAttempts(),
    ]);
    return _MyAccessData(
      results[0] as List<AccessDoor>,
      results[1] as List<MyCredential>,
      results[2] as List<AccessAttempt>,
    );
  }

  Future<void> _refresh() async {
    final next = _load();
    setState(() {
        _future = next;
      });
    await next.catchError((_) => const _MyAccessData([], [], []));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ScreenScaffold(
      title: 'Mis accesos',
      location: widget.residence.location,
      showBack: false,
      onRefresh: _refresh,
      body: FutureBuilder<_MyAccessData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return const LoadingView();
          if (snapshot.hasError) {
            final error = snapshot.error;
            return ErrorView(message: error is ApiException ? error.message : '$error', onRetry: _refresh);
          }
          final data = snapshot.data!;
          final doorNames = {for (final d in data.doors) d.deviceCode: d.name};
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionHeader('Puertas'),
              if (data.doors.isEmpty) const EmptyView(message: 'No tienes puertas asignadas.', icon: Icons.door_front_door_outlined),
              for (final door in data.doors) ...[
                AppCard(
                  child: Row(
                    children: [
                      const Icon(Icons.door_front_door_outlined),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(door.name, style: textTheme.titleSmall),
                            Text(door.location, style: textTheme.bodySmall),
                          ],
                        ),
                      ),
                      Builder(builder: (_) {
                        final (label, tone) = IotLabels.deviceStatus(door.status);
                        return StatusChip(label, tone: tone);
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              const SectionHeader('Mis tarjetas'),
              if (data.credentials.isEmpty) const EmptyView(message: 'No tienes tarjetas registradas.', icon: Icons.credit_card_off_outlined),
              for (final credential in data.credentials) ...[
                AppCard(
                  child: Row(
                    children: [
                      const Icon(Icons.badge_outlined),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tarjeta ${credential.rfidUid}', style: textTheme.titleSmall),
                            Text(
                              credential.validUntil == null
                                  ? 'Sin fecha de vencimiento'
                                  : 'Válida hasta ${Formatters.instant(credential.validUntil)}',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Builder(builder: (_) {
                        final (label, tone) = AccessLabels.credentialStatus(credential.status);
                        return StatusChip(label, tone: tone);
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              const SectionHeader('Intentos recientes'),
              if (data.attempts.isEmpty) const EmptyView(message: 'Aún no hay intentos de acceso.', icon: Icons.history),
              for (final attempt in data.attempts) ...[
                AppCard(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  child: Row(
                    children: [
                      Icon(attempt.granted ? Icons.lock_open : Icons.block,
                          color: attempt.granted ? AppColors.success : AppColors.error),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(doorNames[attempt.deviceCode] ?? attempt.deviceCode, style: textTheme.titleSmall),
                            Text(
                              '${AccessLabels.reason(attempt.reason)} · ${Formatters.instant(attempt.occurredAt)}',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
            ],
          );
        },
      ),
    );
  }
}
