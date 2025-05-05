import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/dashboard/ui/view/dashboard_screen.dart';
import 'package:task_master/splash/ui/cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final bloc = getIt<SplashCubit>();

  @override
  void initState() {
    super.initState();
    bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      bloc: bloc,
      listener: _listenNavigationFlow,
      child: const Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Loading...'), Gap(AppSpacing.s), CircularProgressIndicator()]),
        ),
      ),
    );
  }

  void _listenNavigationFlow(BuildContext context, SplashState state) {
    switch (state.navigation) {
      case SplashNavigation.home:
        context.goNamed(DashboardScreen.routeName);
      default:
        context.goNamed(LoginScreen.routeName);
    }
  }
}
