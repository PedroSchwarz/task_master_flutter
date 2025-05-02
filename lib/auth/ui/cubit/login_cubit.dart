import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_master/auth/data/repository/auth_repository.dart';

part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepository})
    : super(
        const LoginState(
          email: 'pedro@hotmail.com',
          password: 'Penacional1!',
          hidePassword: true,
          isLoading: false,
          isAuthenticated: false,
        ),
      );

  @visibleForTesting
  final AuthRepository authRepository;

  void updateEmail(String email) {
    emit(state.copyWith(email: email, errorMessage: null));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password, errorMessage: null));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(hidePassword: !state.hidePassword, errorMessage: null));
  }

  void login() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await authRepository.login(state.email, state.password);

    switch (result) {
      case LoginResult.success:
        emit(state.copyWith(isAuthenticated: true));
      case LoginResult.userNotFound:
        emit(state.copyWith(errorMessage: "Account doesn't exist."));
      case LoginResult.networkError:
        emit(state.copyWith(errorMessage: 'Unable to login.'));
    }

    emit(state.copyWith(isLoading: false));
  }
}

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState({
    required String email,
    required String password,
    required bool hidePassword,
    required bool isLoading,
    required bool isAuthenticated,
    String? errorMessage,
  }) = _LoginState;

  const LoginState._();

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  bool get isButtonEnabled => isFormValid && !isLoading;
}
