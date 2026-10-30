import 'package:dio/dio.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/events/data_changes.dart';
import '../../../core/network/api_client.dart';
import '../domain/forum_repository.dart';
import '../domain/post.dart';

class ForumRepositoryImpl implements ForumRepository {
  ForumRepositoryImpl(this._dio, [this._changes]);

  final Dio _dio;
  final DataChanges? _changes;

  /// La fake API responde `{ content: [...] }` (Page de Spring).
  @override
  Future<List<Post>> getPosts() => guardApiCall(() async {
        final response = await _dio.get<Object>(ApiEndpoints.posts);
        return parseList(response.data, Post.fromJson);
      });

  @override
  Future<Post> createPost({required int residentId, required String title, required String content}) =>
      guardApiCall(() async {
        final response = await _dio.post<Map<String, dynamic>>(
          ApiEndpoints.posts,
          data: {
            'residentId': residentId,
            'title': title,
            'content': content,
            // json-server no genera la fecha; un microservicio real la ignoraría.
            'createdAt': DateTime.now().toIso8601String(),
          },
        );
        _changes?.notify();
        return Post.fromJson(response.data!);
      });
}
