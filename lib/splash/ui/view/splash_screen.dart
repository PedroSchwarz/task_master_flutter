import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/dashboard/ui/view/screens/dashboard_screen.dart';
import 'package:task_master/splash/ui/cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final bloc = getIt<SplashCubit>();
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    bloc.load();

    _animationController = AnimationController(vsync: this);
    _animation = CurvedAnimation(
      parent: Tween(begin: 0.6, end: 1.0).animate(_animationController),
      curve: Curves.decelerate,
    );
    _animationController.repeat(
      period: const Duration(seconds: 2),
      reverse: true,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      bloc: bloc,
      listener: _listenNavigationFlow,
      child: Scaffold(
        body: Center(
          child: ScaleTransition(scale: _animation, child: const AppLogo()),
        ),
      ),
    );
  }

  void _listenNavigationFlow(BuildContext context, SplashState state) {
    switch (state.navigation) {
      case .home:
        context.goNamed(DashboardScreen.routeName);
      default:
        context.goNamed(LoginScreen.routeName);
    }
  }
}
