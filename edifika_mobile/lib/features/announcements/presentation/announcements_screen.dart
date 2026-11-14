import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/presentation/residence_gate.dart';
import '../domain/announcement.dart';
import '../domain/announcements_repository.dart';

part 'announcements_screen.freezed.dart';

@freezed
abstract class AnnouncementsState with _$AnnouncementsState {
  const factory AnnouncementsState({
    @Default(LoadStatus.loading) LoadStatus status,
    String? error,
    @Default(<Announcement>[]) List<Announcement> items,
    @Default(<int>{}) Set<int> readIds,

    /// El servicio no existe aún en la fake API (404).
    @Default(false) bool unavailable,
  }) = _AnnouncementsState;
}

/// Mockup 09 · Anuncios, con confirmación de lectura.
class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  AnnouncementsCubit(this._repository) : super(const AnnouncementsState());

  final AnnouncementsRepository _repository;

  Future<void> load({required int buildingId, required int userId}) async {
    emit(state.copyWith(status: LoadStatus.loading, error: null));
    try {
      final items = await _repository.getByBuilding(buildingId);
      // Las lecturas confirmadas en esta sesion se conservan al recargar.
      emit(AnnouncementsState(
        status: LoadStatus.ready,
        items: items.reversed.toList(),
        readIds: state.readIds,
      ));
    } on ApiException catch (error) {
      if (error.kind == ApiErrorKind.notFound) {
        emit(const AnnouncementsState(status: LoadStatus.ready, unavailable: true));
      } else {
        emit(state.copyWith(status: LoadStatus.failure, error: error.message));
      }
    }
  }

  Future<String?> confirmRead({required int announcementId, required int userId}) async {
    try {
      await _repository.confirmRead(announcementId: announcementId, userId: userId);
      emit(state.copyWith(readIds: {...state.readIds, announcementId}));
      return null;
    } on ApiException catch (error) {
      // El backend responde error (403) si la lectura ya estaba registrada.
      if (error.statusCode == 403) {
        emit(state.copyWith(readIds: {...state.readIds, announcementId}));
        return 'Ya habías confirmado la lectura de este anuncio.';
      }
      return error.message;
    }
  }
}

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResidenceGate(
      builder: (context, user, residence) {
        return BlocProvider(
          create: (context) =>
              AnnouncementsCubit(context.read())..load(buildingId: residence.building.id, userId: user.id),
          child: Builder(
            builder: (context) {
              final cubit = context.read<AnnouncementsCubit>();
              Future<void> reload() => cubit.load(buildingId: residence.building.id, userId: user.id);
              return ScreenScaffold(
                title: 'Anuncios',
                location: residence.location,
                showBack: false,
                onRefresh: reload,
                body: BlocBuilder<AnnouncementsCubit, AnnouncementsState>(
                  builder: (context, state) {
                    if (state.status == LoadStatus.loading) return const LoadingView();
                    if (state.status == LoadStatus.failure) return ErrorView(message: state.error ?? '', onRetry: reload);
                    if (state.unavailable) {
                      return const PendingIntegrationCard(
                        title: 'Anuncios',
                        message: 'Aquí verás los comunicados oficiales de tu edificio y podrás confirmar su lectura. '
                            'El servicio de comunicados aún no está disponible en la API.',
                      );
                    }
                    if (state.items.isEmpty) {
                      return const EmptyView(message: 'No hay anuncios de tu edificio.', icon: Icons.campaign_outlined);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final a in state.items) ...[
                          _AnnouncementCard(
                            announcement: a,
                            read: state.readIds.contains(a.id),
                            onConfirm: () async {
                              final messenger = ScaffoldMessenger.of(context);
                              final error = await cubit.confirmRead(announcementId: a.id, userId: user.id);
                              messenger.showSnackBar(SnackBar(content: Text(error ?? 'Lectura confirmada.')));
                            },
                          ),
                          const SizedBox(height: AppSpacing.md),
                        ],
                      ],
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  const _AnnouncementCard({required this.announcement, required this.read, required this.onConfirm});

  final Announcement announcement;
  final bool read;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      tone: read ? AppCardTone.plain : AppCardTone.highlighted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${announcement.priority.toUpperCase()} · ${Formatters.date(announcement.createdAt ?? '')}',
                  style: textTheme.labelSmall?.copyWith(color: AppColors.primary),
                ),
              ),
              StatusChip(read ? 'Leído' : 'No leído', tone: read ? StatusTone.neutral : StatusTone.pending),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(announcement.title, style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(announcement.message.isEmpty ? announcement.description : announcement.message, style: textTheme.bodyMedium),
          if (!read) ...[
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(onPressed: onConfirm, icon: const Icon(Icons.done_all), label: const Text('Confirmar lectura')),
          ],
        ],
      ),
    );
  }
}
