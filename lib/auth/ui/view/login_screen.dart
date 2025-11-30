import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/dashboard/ui/view/screens/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = getIt<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;

    return BlocListener<LoginCubit, LoginState>(
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
            title: Text(localization.login),
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: const Size(0, AppSpacing.s),
              child: BlocSelector<LoginCubit, LoginState, bool>(
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
                      padding: const .fromLTRB(
                        AppSpacing.s,
                        AppSpacing.s,
                        AppSpacing.s,
                        0,
                      ),
                      child: Column(
                        spacing: AppSpacing.s,
                        mainAxisAlignment: .spaceBetween,
                        crossAxisAlignment: .stretch,
                        children: [
                          const Gap(AppSpacing.s),
                          Column(
                            spacing: AppSpacing.s,
                            children: [
                              const AppLogo().animate().fade(),
                              Text(
                                'Task Master',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineLarge,
                              ).animate().fade(delay: 100.ms),
                            ],
                          ),
                          Column(
                            spacing: AppSpacing.s,
                            crossAxisAlignment: .stretch,
                            children: [
                              AppTextField(
                                label: localization.email,
                                onChanged: bloc.updateEmail,
                                keyboardType: TextInputType.emailAddress,
                                textCapitalization: .none,
                              ),
                              BlocSelector<LoginCubit, LoginState, bool>(
                                bloc: bloc,
                                selector: (state) => state.hidePassword,
                                builder: (context, hidePassword) =>
                                    AppTextField(
                                      label: localization.password,
                                      onChanged: bloc.updatePassword,
                                      obscureText: hidePassword,
                                      suffixIcon: TogglePasswordButton(
                                        onPressed:
                                            bloc.togglePasswordVisibility,
                                        value: hidePassword,
                                      ),
                                    ),
                              ),
                              BlocSelector<LoginCubit, LoginState, String?>(
                                bloc: bloc,
                                selector: (state) => switch (state.error) {
                                  .userNotFound =>
                                    localization.login_user_not_found_error,
                                  .networkError =>
                                    localization.login_generic_error,
                                  _ => null,
                                },
                                builder: (context, errorMessage) =>
                                    errorMessage != null
                                    ? Text(
                                        errorMessage,
                                        textAlign: .start,
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: .stretch,
                            children: [
                              BlocSelector<LoginCubit, LoginState, bool>(
                                bloc: bloc,
                                selector: (state) => state.canSubmit,
                                builder: (context, canSubmit) {
                                  return FilledButton(
                                    onPressed: canSubmit ? bloc.login : null,
                                    child: Text(localization.login),
                                  );
                                },
                              ),
                              BlocSelector<LoginCubit, LoginState, bool>(
                                bloc: bloc,
                                selector: (state) => state.isSubmitting,
                                builder: (context, isSubmitting) {
                                  return TextButton(
                                    onPressed: isSubmitting
                                        ? null
                                        : () => context.pushNamed(
                                            RegisterScreen.routeName,
                                          ),
                                    child: Text(
                                      localization.create_new_account,
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

  void _listenNavigationFlow(BuildContext context, LoginState state) {
    if (state.isAuthenticated) {
      context.goNamed(DashboardScreen.routeName);
    }
  }
}
