import 'authenticated_user.dart';

abstract class AuthRepository {
  Future<AuthenticatedUser> signIn({required String email, required String password, bool remember = true});

  /// Sesión guardada en el dispositivo, o `null` si no hay / expiró.
  Future<AuthenticatedUser?> restoreSession();

  Future<void> signOut();
}
