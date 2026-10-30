import 'user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getProfile(int userId);

  Future<UserProfile> updateProfile(UserProfile profile);

  /// Vecinos del edificio, para mostrar el autor de cada publicación.
  Future<List<UserProfile>> getUsers();
}
