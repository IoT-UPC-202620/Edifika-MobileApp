import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../auth/presentation/residence_gate.dart';
import '../domain/post.dart';
import 'forum_cubits.dart';

/// Datos que recibe "Tema del foro".
class PostDetailArgs {
  const PostDetailArgs({required this.post, required this.authorName});

  final Post post;
  final String authorName;
}

/// Mockup 10 · Comunidades.
class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResidenceGate(
      builder: (context, user, residence) => BlocProvider(
        create: (context) => ForumCubit(context.read(), context.read())..load(),
        child: Builder(
          builder: (context) {
            final cubit = context.read<ForumCubit>();
            final textTheme = Theme.of(context).textTheme;
            return ScreenScaffold(
              title: 'Comunidades',
              location: residence.location,
              showBack: false,
              onRefresh: cubit.load,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Conecta con tus vecinos, comparte ideas y participa en el foro de ${residence.building.name}.',
                    style: textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  LabeledField(
                    label: 'Buscar en comunidades',
                    child: TextField(
                      onChanged: cubit.search,
                      textInputAction: TextInputAction.search,
                      decoration: const InputDecoration(hintText: 'Buscar temas o vecinos', suffixIcon: Icon(Icons.search)),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: () async {
                      await context.push<void>('/community/new');
                      await cubit.load();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Crear publicación'),
                  ),
                  const SectionHeader('Foros de residentes'),
                  const PendingIntegrationCard(
                    title: 'Foros temáticos',
                    message: 'Las comunidades por tema (p. ej. Vida verde, Entre vecinos) llegarán cuando el servicio '
                        'de foro las soporte. Por ahora todas las publicaciones van al foro general.',
                  ),
                  const SectionHeader('Temas recientes'),
                  BlocBuilder<ForumCubit, ForumState>(
                    builder: (context, state) {
                      if (state.status == LoadStatus.loading) return const LoadingView();
                      if (state.status == LoadStatus.failure) {
                        return ErrorView(message: state.error ?? '', onRetry: cubit.load);
                      }
                      if (state.visible.isEmpty) {
                        return EmptyView(
                          message: state.query.isEmpty ? 'Aún no hay publicaciones. ¡Sé el primero!' : 'No hay temas que coincidan.',
                          icon: Icons.forum_outlined,
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final post in state.visible) ...[
                            _TopicCard(
                              post: post,
                              author: state.authorOf(post),
                              onTap: () => context.push(
                                '/community/post',
                                extra: PostDetailArgs(post: post, authorName: state.authorOf(post)),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                          ],
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.post, required this.author, required this.onTap});

  final Post post;
  final String author;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Foro general', style: textTheme.labelSmall?.copyWith(color: AppColors.primary)),
          const SizedBox(height: AppSpacing.sm),
          Text(post.title, style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Text('$author · ${Formatters.date(post.createdAt ?? '')}', style: textTheme.bodySmall),
          const SizedBox(height: AppSpacing.md),
          Text('Ver tema →', style: textTheme.labelMedium?.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }
}
