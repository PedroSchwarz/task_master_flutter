import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/auth/auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final bloc = getIt<RegisterCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      bloc: bloc,
      listenWhen:
          (previous, current) =>
              previous.isAuthenticated != current.isAuthenticated,
      listener: _listenNavigationFlow,
      child: Scaffold(
        appBar: AppBar(title: const Text('Register'), centerTitle: false),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s),
            child: Column(
              spacing: AppSpacing.s,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocSelector<RegisterCubit, RegisterState, bool>(
                  bloc: bloc,
                  selector: (state) => state.isLoading,
                  builder:
                      (context, isLoading) =>
                          isLoading
                              ? const LinearProgressIndicator()
                              : const SizedBox.shrink(),
                ),
                const Spacer(),
                AppTextField(
                  label: 'First Name',
                  onChanged: bloc.updateFirstName,
                  textCapitalization: TextCapitalization.words,
                ),
                AppTextField(
                  label: 'Last Name',
                  onChanged: bloc.updateLastName,
                  textCapitalization: TextCapitalization.words,
                ),
                BlocSelector<RegisterCubit, RegisterState, String?>(
                  bloc: bloc,
                  selector: (state) => state.emailError,
                  builder:
                      (context, emailError) => AppTextField(
                        label: 'Email',
                        onChanged: bloc.updateEmail,
                        keyboardType: TextInputType.emailAddress,
                        error: emailError,
                        textCapitalization: TextCapitalization.none,
                      ),
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  bloc: bloc,
                  builder:
                      (context, state) => Column(
                        spacing: AppSpacing.s,
                        children: [
                          AppTextField(
                            label: 'Password',
                            onChanged: bloc.updatePassword,
                            obscureText: state.hidePassword,
                            error: state.passwordError,
                            suffixIcon: TogglePasswordButton(
                              onPressed: bloc.togglePasswordVisibility,
                              value: state.hidePassword,
                            ),
                          ),
                          AppTextField(
                            label: 'Confirm Password',
                            onChanged: bloc.updateConfirmPassword,
                            obscureText: state.hidePassword,
                            error: state.confirmPasswordError,
                            suffixIcon: TogglePasswordButton(
                              onPressed: bloc.togglePasswordVisibility,
                              value: state.hidePassword,
                            ),
                          ),
                        ],
                      ),
                ),
                BlocSelector<RegisterCubit, RegisterState, String?>(
                  bloc: bloc,
                  selector: (state) => state.errorMessage,
                  builder:
                      (context, errorMessage) =>
                          errorMessage != null
                              ? Text(errorMessage)
                              : const SizedBox.shrink(),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocSelector<RegisterCubit, RegisterState, bool>(
                      bloc: bloc,
                      selector: (state) => state.isButtonEnabled,
                      builder:
                          (context, isEnabled) => FilledButton(
                            onPressed: isEnabled ? bloc.register : null,
                            child: const Text('Register'),
                          ),
                    ),
                    BlocSelector<RegisterCubit, RegisterState, bool>(
                      bloc: bloc,
                      selector: (state) => state.isLoading,
                      builder:
                          (context, isLoading) => TextButton(
                            onPressed: isLoading ? null : context.pop,
                            child: const Text(
                              'Login',
                              textAlign: TextAlign.start,
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _listenNavigationFlow(BuildContext context, RegisterState state) {
    if (state.isAuthenticated) {
      context.goNamed(LoginScreen.routeName);
    }
  }
}
