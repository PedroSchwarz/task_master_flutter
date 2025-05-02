import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_master/auth/data/repository/auth_repository.dart';

part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.authRepository})
    : super(
        const RegisterState(
          firstName: '',
          lastName: '',
          email: '',
          password: '',
          confirmPassword: '',
          hidePassword: true,
          isLoading: false,
          isAuthenticated: false,
        ),
      );

  @visibleForTesting
  final AuthRepository authRepository;

  void updateFirstName(String firstName) {
    emit(state.copyWith(firstName: firstName, errorMessage: null));
  }

  void updateLastName(String lastName) {
    emit(state.copyWith(lastName: lastName, errorMessage: null));
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email, errorMessage: null));

    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(email)) {
      emit(state.copyWith(emailError: 'Invalid email'));
    } else {
      emit(state.copyWith(emailError: null));
    }
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password, errorMessage: null));

    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$',
    );
    if (!passwordRegex.hasMatch(password)) {
      emit(state.copyWith(passwordError: 'Invalid password'));
    } else {
      emit(state.copyWith(passwordError: null));
    }

    if (state.confirmPassword.isNotEmpty && password != state.confirmPassword) {
      emit(state.copyWith(confirmPasswordError: 'Passwords do not match'));
    } else {
      emit(state.copyWith(confirmPasswordError: null));
    }
  }

  void updateConfirmPassword(String password) {
    emit(state.copyWith(confirmPassword: password, errorMessage: null));

    if (password != state.password) {
      emit(state.copyWith(confirmPasswordError: 'Passwords do not match'));
    } else {
      emit(state.copyWith(confirmPasswordError: null));
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(hidePassword: !state.hidePassword, errorMessage: null));
  }

  Future<void> register() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await authRepository.register(
      firstName: state.firstName,
      lastName: state.lastName,
      email: state.email,
      password: state.password,
    );

    switch (result) {
      case RegisterResult.success:
        emit(state.copyWith(isAuthenticated: true));
      case RegisterResult.emailConflict:
        emit(state.copyWith(errorMessage: 'Email already in use.'));
      case RegisterResult.networkError:
        emit(state.copyWith(errorMessage: 'Unable to register.'));
    }

    emit(state.copyWith(isLoading: false));
  }
}

@freezed
sealed class RegisterState with _$RegisterState {
  const factory RegisterState({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required bool hidePassword,
    required bool isLoading,
    required bool isAuthenticated,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? errorMessage,
  }) = _RegisterState;

  const RegisterState._();

  bool get isFormValid =>
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      emailError == null &&
      passwordError == null &&
      confirmPasswordError == null;

  bool get isButtonEnabled => isFormValid && !isLoading;
}
