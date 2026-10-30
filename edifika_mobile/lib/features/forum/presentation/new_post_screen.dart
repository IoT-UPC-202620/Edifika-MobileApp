import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/presentation/residence_gate.dart';
import '../../profile/presentation/account_sheet.dart';
import 'forum_cubits.dart';

/// Mockup 12 · Nueva publicación.
class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResidenceGate(
      builder: (context, user, residence) => BlocProvider(
        create: (context) => NewPostCubit(context.read(), residentId: user.id),
        child: BlocListener<NewPostCubit, NewPostState>(
          listenWhen: (a, b) => a.created == null && b.created != null,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Publicación creada.')));
            context.pop();
          },
          child: ScreenScaffold(
            title: 'Nueva publicación',
            location: residence.location,
            body: _NewPostForm(
              authorName: user.fullName,
              authorRole: roleLabel(user.roles).toLowerCase(),
              buildingName: residence.building.name,
              unitNumber: residence.unit?.unitNumber,
            ),
          ),
        ),
      ),
    );
  }
}

class _NewPostForm extends StatefulWidget {
  const _NewPostForm({required this.authorName, required this.authorRole, required this.buildingName, this.unitNumber});

  final String authorName;
  final String authorRole;
  final String buildingName;
  final int? unitNumber;

  @override
  State<_NewPostForm> createState() => _NewPostFormState();
}

class _NewPostFormState extends State<_NewPostForm> {
  final _title = TextEditingController();
  final _message = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<NewPostCubit, NewPostState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                InitialsAvatar(widget.authorName),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.authorName, style: textTheme.bodyLarge),
                      Text(
                        'Publicando como ${widget.authorRole}'
                        '${widget.unitNumber == null ? '' : ' · Dpto. ${widget.unitNumber}'}',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const StatusChip('Borrador'),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Inicia una conversación con tus vecinos y comparte tu idea.',
              style: textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.xl),
            LabeledField(
              label: 'Título',
              child: TextField(
                controller: _title,
                maxLength: NewPostCubit.maxTitle,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'Ej.: Intercambio de plantas entre vecinos', counterText: ''),
              ),
            ),
            LabeledField(
              label: 'Mensaje',
              child: TextField(
                controller: _message,
                minLines: 6,
                maxLines: 12,
                decoration: const InputDecoration(hintText: 'Escribe tu mensaje'),
              ),
            ),
            // Subida de imágenes (Cloudinary): solo interfaz, sin integración.
            OutlinedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('Adjuntar imagen'),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text('Adjuntar imágenes: pendiente de integración.', style: textTheme.bodySmall),
            const SizedBox(height: AppSpacing.lg),
            InfoBanner(
              title: 'Un espacio para conversar',
              message: 'Tu tema será visible para residentes de ${widget.buildingName}. '
                  'Evita compartir datos personales y mantén un tono respetuoso.',
            ),
            if (state.error != null) ...[
              const SizedBox(height: AppSpacing.md),
              Semantics(
                liveRegion: true,
                child: Text(state.error!, style: textTheme.bodyMedium?.copyWith(color: AppColors.error)),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: state.submitting
                  ? null
                  : () => context.read<NewPostCubit>().publish(title: _title.text, content: _message.text),
              icon: state.submitting
                  ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.send_outlined),
              label: Text(state.submitting ? 'Publicando…' : 'Publicar'),
            ),
          ],
        );
      },
    );
  }
}
