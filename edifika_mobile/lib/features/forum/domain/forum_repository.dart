import 'post.dart';

abstract class ForumRepository {
  Future<List<Post>> getPosts();

  Future<Post> createPost({required int residentId, required String title, required String content});
}
