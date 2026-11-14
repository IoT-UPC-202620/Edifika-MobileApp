import 'package:flutter/material.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/presentation/residence_gate.dart';
import 'community_screen.dart';

/// Mockup 11 · Tema del foro.
class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key, required this.args});

  final PostDetailArgs args;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final post = args.post;
    return ResidenceGate(
      builder: (context, user, residence) => ScreenScaffold(
        title: 'Tema del foro',
        location: residence.location,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(alignment: Alignment.centerLeft, child: StatusChip('Foro general', tone: StatusTone.pending)),
            const SizedBox(height: AppSpacing.lg),
            Semantics(header: true, child: Text(post.title, style: textTheme.headlineMedium?.copyWith(fontSize: 24))),
            const SizedBox(height: AppSpacing.lg),
            AppCard(
              tone: post.residentId == user.id ? AppCardTone.highlighted : AppCardTone.plain,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InitialsAvatar(args.authorName),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          [
                            post.residentId == user.id ? '${args.authorName} · Tú' : args.authorName,
                            if (args.authorRole.isNotEmpty) args.authorRole,
                          ].join(' · '),
                          style: textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(Formatters.dateTime(post.createdAt), style: textTheme.bodySmall),
                  const SizedBox(height: AppSpacing.md),
                  Text(post.content, style: textTheme.bodyLarge?.copyWith(fontSize: 15)),
                ],
              ),
            ),
            const SectionHeader('Respuestas'),
            const PendingIntegrationCard(
              title: 'Respuestas',
              message: 'Podrás leer y responder a tus vecinos cuando el servicio de foro soporte respuestas.',
            ),
            const SizedBox(height: AppSpacing.lg),
            LabeledField(
              label: 'Escribe una respuesta · ${user.fullName}',
              child: const TextField(
                enabled: false,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(hintText: 'Disponible próximamente'),
              ),
            ),
            FilledButton.icon(onPressed: null, icon: const Icon(Icons.send_outlined), label: const Text('Publicar')),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Tu respuesta será visible para los vecinos de ${residence.building.name}. Participa con respeto.',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
