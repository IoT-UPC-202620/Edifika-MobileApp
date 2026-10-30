import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/utils/load_status.dart';
import '../domain/app_notification.dart';
import '../domain/notifications_repository.dart';

part 'notifications_cubit.freezed.dart';

@freezed
abstract class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(LoadStatus.loading) LoadStatus status,
    String? error,
    @Default(<AppNotification>[]) List<AppNotification> items,
    String? message,
  }) = _NotificationsState;

  const NotificationsState._();

  int get unread => items.where((n) => !n.read).length;
}

/// Mockup 08 · Notificaciones.
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repository) : super(const NotificationsState());

  final NotificationsRepository _repository;

  Future<void> load(int userId) async {
    emit(state.copyWith(status: LoadStatus.loading, error: null));
    try {
      emit(NotificationsState(status: LoadStatus.ready, items: await _repository.getByUser(userId)));
    } on ApiException catch (error) {
      emit(state.copyWith(status: LoadStatus.failure, error: error.message));
    }
  }

  Future<void> markRead(int id) async {
    try {
      final updated = await _repository.markAsRead(id);
      emit(state.copyWith(items: [for (final n in state.items) n.id == id ? updated : n]));
    } on ApiException catch (error) {
      emit(state.copyWith(message: error.message));
    }
  }

  Future<void> markAllRead() async {
    for (final n in state.items.where((n) => !n.read).toList()) {
      await markRead(n.id);
    }
  }
}
