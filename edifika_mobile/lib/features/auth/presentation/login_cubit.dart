import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../domain/auth_repository.dart';
import '../domain/authenticated_user.dart';

part 'login_cubit.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(true) bool remember,
    @Default(false) bool submitting,
    String? error,
    AuthenticatedUser? user,
  }) = _LoginState;
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._auth) : super(const LoginState());

  final AuthRepository _auth;

  void toggleRemember(bool value) => emit(state.copyWith(remember: value));

  Future<void> submit({required String email, required String password}) async {
    if (email.trim().isEmpty || password.isEmpty) {
      emit(state.copyWith(error: 'Ingresa tu correo y tu contraseña.'));
      return;
    }
    emit(state.copyWith(submitting: true, error: null));
    try {
      final user = await _auth.signIn(email: email.trim(), password: password, remember: state.remember);
      if (!user.isResident) {
        // La app es para residentes; la administración usa la aplicación web.
        await _auth.signOut();
        emit(state.copyWith(
          submitting: false,
          error: 'Esta app es para propietarios e inquilinos. La administración ingresa desde la aplicación web.',
        ));
        return;
      }
      emit(state.copyWith(submitting: false, user: user));
    } on ApiException catch (error) {
      emit(state.copyWith(submitting: false, error: error.message));
    }
  }
}
