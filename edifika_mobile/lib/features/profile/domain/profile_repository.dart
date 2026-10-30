import 'user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getProfile(int userId);

  Future<UserProfile> updateProfile(UserProfile profile);
}
