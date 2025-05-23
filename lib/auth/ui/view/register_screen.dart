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
    return BlocListener<RegisterCubit, RegisterState>(
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
            title: const Text('Register'),
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: const Size(0, AppSpacing.s),
              child: BlocSelector<RegisterCubit, RegisterState, bool>(
                bloc: bloc,
                selector: (state) => state.isSubmitting,
                builder: (context, isSubmitting) => isSubmitting ? const LinearProgressIndicator() : const SizedBox.shrink(),
              ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.s, AppSpacing.s, AppSpacing.s, 0),
                      child: Column(
                        spacing: AppSpacing.s,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Gap(AppSpacing.s),
                          Column(
                            spacing: AppSpacing.s,
                            children: [
                              AppTextField(label: 'First Name', onChanged: bloc.updateFirstName, textCapitalization: TextCapitalization.words),
                              AppTextField(label: 'Last Name', onChanged: bloc.updateLastName, textCapitalization: TextCapitalization.words),
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
                                          suffixIcon: TogglePasswordButton(onPressed: bloc.togglePasswordVisibility, value: state.hidePassword),
                                        ),
                                        AppTextField(
                                          label: 'Confirm Password',
                                          onChanged: bloc.updateConfirmPassword,
                                          obscureText: state.hidePassword,
                                          error: state.confirmPasswordError,
                                          suffixIcon: TogglePasswordButton(onPressed: bloc.togglePasswordVisibility, value: state.hidePassword),
                                        ),
                                      ],
                                    ),
                              ),
                              BlocSelector<RegisterCubit, RegisterState, String?>(
                                bloc: bloc,
                                selector: (state) => state.errorMessage,
                                builder: (context, errorMessage) => errorMessage != null ? Text(errorMessage) : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              BlocSelector<RegisterCubit, RegisterState, bool>(
                                bloc: bloc,
                                selector: (state) => state.canSubmit,
                                builder: (context, canSubmit) {
                                  return FilledButton(onPressed: canSubmit ? bloc.register : null, child: const Text('Register'));
                                },
                              ),
                              BlocSelector<RegisterCubit, RegisterState, bool>(
                                bloc: bloc,
                                selector: (state) => state.isSubmitting,
                                builder: (context, isSubmitting) {
                                  return TextButton(
                                    onPressed: isSubmitting ? null : context.pop,
                                    child: const Text('Access Account', textAlign: TextAlign.start),
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
