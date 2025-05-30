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
            title: Text(localization.register),
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AppTextField(
                                label: localization.first_name,
                                onChanged: bloc.updateFirstName,
                                textCapitalization: TextCapitalization.words,
                              ),
                              AppTextField(
                                label: localization.last_name,
                                onChanged: bloc.updateLastName,
                                textCapitalization: TextCapitalization.words,
                              ),
                              BlocSelector<RegisterCubit, RegisterState, String?>(
                                bloc: bloc,
                                selector: (state) => state.emailError ? localization.invalid_email : null,
                                builder:
                                    (context, emailError) => AppTextField(
                                      label: localization.email,
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
                                          label: localization.password,
                                          onChanged: bloc.updatePassword,
                                          obscureText: state.hidePassword,
                                          error: state.passwordError ? localization.invalid_password : null,
                                          suffixIcon: TogglePasswordButton(onPressed: bloc.togglePasswordVisibility, value: state.hidePassword),
                                        ),
                                        AnimatedLinearProgressIndicator(value: state.passwordStrength, color: state.passwordStrengthColor),
                                        AppTextField(
                                          label: localization.confirm_password,
                                          onChanged: bloc.updateConfirmPassword,
                                          obscureText: state.hidePassword,
                                          error: state.confirmPasswordError ? localization.invalid_confirm_password : null,
                                          suffixIcon: TogglePasswordButton(onPressed: bloc.togglePasswordVisibility, value: state.hidePassword),
                                        ),
                                      ],
                                    ),
                              ),
                              BlocSelector<RegisterCubit, RegisterState, String?>(
                                bloc: bloc,
                                selector:
                                    (state) => switch (state.error) {
                                      RegisterResult.emailConflict => localization.register_email_conflict_error,
                                      RegisterResult.networkError => localization.register_generic_error,
                                      _ => null,
                                    },
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
                                  return FilledButton(onPressed: canSubmit ? bloc.register : null, child: Text(localization.register));
                                },
                              ),
                              BlocSelector<RegisterCubit, RegisterState, bool>(
                                bloc: bloc,
                                selector: (state) => state.isSubmitting,
                                builder: (context, isSubmitting) {
                                  return TextButton(
                                    onPressed: isSubmitting ? null : context.pop,
                                    child: Text(localization.access_account, textAlign: TextAlign.start),
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

class AnimatedLinearProgressIndicator extends StatefulWidget {
  const AnimatedLinearProgressIndicator({super.key, required this.value, required this.color});

  final double value;
  final Color color;

  @override
  State<AnimatedLinearProgressIndicator> createState() => _AnimatedLinearProgressIndicatorState();
}

class _AnimatedLinearProgressIndicatorState extends State<AnimatedLinearProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _oldValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _updateAnimation(initial: true);
  }

  @override
  void didUpdateWidget(covariant AnimatedLinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _oldValue = oldWidget.value;
      _updateAnimation();
    }
  }

  void _updateAnimation({bool initial = false}) {
    _animation = Tween<double>(
      begin: initial ? 0.0 : _oldValue,
      end: widget.value,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) => LinearProgressIndicator(value: _animation.value, color: widget.color, backgroundColor: widget.color.withOpacity(0.2)),
    );
  }
}
