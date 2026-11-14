import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required int id,
    required String title,
    required String content,
    required int residentId,
    String? imageUrl,
    String? createdAt,

    /// Rol del autor al publicar (ADMIN, OWNER o TENANT), guardado por Forum desde el JWT.
    String? authorRole,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
