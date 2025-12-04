import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/dashboard/ui/view/screens/dashboard_screen.dart';

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
    final localization = context.localization;

    return BlocListener<RegisterCubit, RegisterState>(
      bloc: bloc,
      listenWhen: (previous, current) =>
          previous.isAuthenticated != current.isAuthenticated,
      listener: _listenNavigationFlow,
      child: GestureDetector(
        onTap: () {
          final scope = FocusScope.of(context);
          if (!scope.hasPrimaryFocus) {
            scope.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(localization.register),
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: const Size(0, AppSpacing.s),
              child: BlocSelector<RegisterCubit, RegisterState, bool>(
                bloc: bloc,
                selector: (state) => state.isSubmitting,
                builder: (context, isSubmitting) => isSubmitting
                    ? const LinearProgressIndicator()
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: .fromLTRB(
                        AppSpacing.s,
                        AppSpacing.s,
                        AppSpacing.s,
                        Platform.isMacOS ? AppSpacing.s : 0,
                      ),
                      child: Column(
                        spacing: AppSpacing.s,
                        mainAxisAlignment: .spaceBetween,
                        crossAxisAlignment: .stretch,
                        children: [
                          const Gap(AppSpacing.s),
                          Column(
                            spacing: AppSpacing.s,
                            crossAxisAlignment: .stretch,
                            children: [
                              AppTextField(
                                label: localization.first_name,
                                onChanged: bloc.updateFirstName,
                                textCapitalization: .words,
                              ),
                              AppTextField(
                                label: localization.last_name,
                                onChanged: bloc.updateLastName,
                                textCapitalization: .words,
                              ),
                              BlocSelector<
                                RegisterCubit,
                                RegisterState,
                                String?
                              >(
                                bloc: bloc,
                                selector: (state) => state.emailError
                                    ? localization.invalid_email
                                    : null,
                                builder: (context, emailError) => AppTextField(
                                  label: localization.email,
                                  onChanged: bloc.updateEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  error: emailError,
                                  textCapitalization: .none,
                                ),
                              ),
                              BlocBuilder<RegisterCubit, RegisterState>(
                                bloc: bloc,
                                builder: (context, state) => Column(
                                  spacing: AppSpacing.s,
                                  children: [
                                    AppTextField(
                                      label: localization.password,
                                      onChanged: bloc.updatePassword,
                                      obscureText: state.hidePassword,
                                      error: state.passwordError
                                          ? localization.invalid_password
                                          : null,
                                      suffixIcon: TogglePasswordButton(
                                        onPressed:
                                            bloc.togglePasswordVisibility,
                                        value: state.hidePassword,
                                      ),
                                    ),
                                    AnimatedLinearProgressIndicator(
                                      value: state.passwordStrength,
                                      color: state.passwordStrengthColor,
                                    ),
                                    AppTextField(
                                      label: localization.confirm_password,
                                      onChanged: bloc.updateConfirmPassword,
                                      obscureText: state.hidePassword,
                                      error: state.confirmPasswordError
                                          ? localization
                                                .invalid_confirm_password
                                          : null,
                                      suffixIcon: TogglePasswordButton(
                                        onPressed:
                                            bloc.togglePasswordVisibility,
                                        value: state.hidePassword,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              BlocSelector<
                                RegisterCubit,
                                RegisterState,
                                String?
                              >(
                                bloc: bloc,
                                selector: (state) => switch (state.error) {
                                  .emailConflict =>
                                    localization.register_email_conflict_error,
                                  .networkError =>
                                    localization.register_generic_error,
                                  _ => null,
                                },
                                builder: (context, errorMessage) =>
                                    errorMessage != null
                                    ? Text(errorMessage)
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: .stretch,
                            children: [
                              BlocSelector<RegisterCubit, RegisterState, bool>(
                                bloc: bloc,
                                selector: (state) => state.canSubmit,
                                builder: (context, canSubmit) {
                                  return FilledButton(
                                    onPressed: canSubmit ? bloc.register : null,
                                    child: Text(localization.register),
                                  );
                                },
                              ),
                              if (Platform.isMacOS) const Gap(AppSpacing.xs),
                              BlocSelector<RegisterCubit, RegisterState, bool>(
                                bloc: bloc,
                                selector: (state) => state.isSubmitting,
                                builder: (context, isSubmitting) {
                                  return TextButton(
                                    onPressed: isSubmitting
                                        ? null
                                        : context.pop,
                                    child: Text(
                                      localization.access_account,
                                      textAlign: .start,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _listenNavigationFlow(BuildContext context, RegisterState state) {
    if (state.isAuthenticated) {
      context.goNamed(DashboardScreen.routeName);
    }
  }
}
