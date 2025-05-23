import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/auth/ui/cubit/login_cubit.dart';
import 'package:task_master/auth/ui/view/register_screen.dart';
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
    return BlocListener<LoginCubit, LoginState>(
      bloc: bloc,
      listenWhen: (previous, current) => previous.isAuthenticated != current.isAuthenticated,
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
            title: const Text('Login'),
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: const Size(0, AppSpacing.s),
              child: BlocSelector<LoginCubit, LoginState, bool>(
                bloc: bloc,
                selector: (state) => state.isSubmitting,
                builder: (context, isSubmitting) => isSubmitting ? const LinearProgressIndicator() : const SizedBox.shrink(),
              ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.s, AppSpacing.s, AppSpacing.s, 0),
              child: Column(
                spacing: AppSpacing.s,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Column(spacing: AppSpacing.s, children: [const AppLogo(), Text('Task Master', style: Theme.of(context).textTheme.headlineLarge)]),
                  const Spacer(),
                  AppTextField(
                    label: 'Email',
                    onChanged: bloc.updateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                  ),
                  BlocSelector<LoginCubit, LoginState, bool>(
                    bloc: bloc,
                    selector: (state) => state.hidePassword,
                    builder:
                        (context, hidePassword) => AppTextField(
                          label: 'Password',
                          onChanged: bloc.updatePassword,
                          obscureText: hidePassword,
                          suffixIcon: TogglePasswordButton(onPressed: bloc.togglePasswordVisibility, value: hidePassword),
                        ),
                  ),
                  BlocSelector<LoginCubit, LoginState, String?>(
                    bloc: bloc,
                    selector: (state) => state.errorMessage,
                    builder: (context, errorMessage) => errorMessage != null ? Text(errorMessage) : const SizedBox.shrink(),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BlocSelector<LoginCubit, LoginState, bool>(
                        bloc: bloc,
                        selector: (state) => state.canSubmit,
                        builder: (context, canSubmit) {
                          return FilledButton(onPressed: canSubmit ? bloc.login : null, child: const Text('Login'));
                        },
                      ),
                      BlocSelector<LoginCubit, LoginState, bool>(
                        bloc: bloc,
                        selector: (state) => state.isSubmitting,
                        builder: (context, isSubmitting) {
                          return TextButton(
                            onPressed: isSubmitting ? null : () => context.pushNamed(RegisterScreen.routeName),
                            child: const Text('Create a New Account', textAlign: TextAlign.start),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
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
