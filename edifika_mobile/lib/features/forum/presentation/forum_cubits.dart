import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/utils/load_status.dart';
import '../../profile/domain/profile_repository.dart';
import '../domain/forum_repository.dart';
import '../domain/post.dart';

part 'forum_cubits.freezed.dart';

@freezed
abstract class ForumState with _$ForumState {
  const factory ForumState({
    @Default(LoadStatus.loading) LoadStatus status,
    String? error,
    @Default(<Post>[]) List<Post> posts,
    @Default(<int, String>{}) Map<int, String> authorNames,
    @Default('') String query,
  }) = _ForumState;

  const ForumState._();

  String authorOf(Post post) => authorNames[post.residentId] ?? 'Vecino';

  List<Post> get visible {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return posts;
    return posts.where((p) => '${p.title} ${p.content} ${authorOf(p)}'.toLowerCase().contains(q)).toList();
  }
}

/// Mockup 10 · Comunidades (temas recientes del foro).
class ForumCubit extends Cubit<ForumState> {
  ForumCubit(this._forum, this._profiles) : super(const ForumState());

  final ForumRepository _forum;
  final ProfileRepository _profiles;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading, error: null));
    try {
      final postsFuture = _forum.getPosts();
      final usersFuture = _profiles.getUsers();
      await Future.wait([postsFuture, usersFuture]);
      final posts = (await postsFuture)..sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
      emit(state.copyWith(
        status: LoadStatus.ready,
        posts: posts,
        authorNames: {for (final u in await usersFuture) u.id: u.fullName},
      ));
    } on ApiException catch (error) {
      emit(state.copyWith(status: LoadStatus.failure, error: error.message));
    }
  }

  void search(String query) => emit(state.copyWith(query: query));
}

@freezed
abstract class NewPostState with _$NewPostState {
  const factory NewPostState({
    @Default(false) bool submitting,
    String? error,
    Post? created,
  }) = _NewPostState;
}

/// Mockup 12 · Nueva publicación.
class NewPostCubit extends Cubit<NewPostState> {
  NewPostCubit(this._forum, {required this.residentId}) : super(const NewPostState());

  final ForumRepository _forum;
  final int residentId;

  static const maxTitle = 120;

  Future<void> publish({required String title, required String content}) async {
    final t = title.trim();
    final c = content.trim();
    if (t.isEmpty || c.isEmpty) {
      emit(state.copyWith(error: 'Escribe un título y un mensaje.'));
      return;
    }
    if (t.length > maxTitle) {
      emit(state.copyWith(error: 'El título puede tener hasta $maxTitle caracteres.'));
      return;
    }
    emit(state.copyWith(submitting: true, error: null));
    try {
      final post = await _forum.createPost(residentId: residentId, title: t, content: c);
      emit(state.copyWith(submitting: false, created: post));
    } on ApiException catch (error) {
      emit(state.copyWith(submitting: false, error: error.message));
    }
  }
}
