import 'package:go_router/go_router.dart';
import 'package:task_master/auth/ui/view/login_screen.dart';
import 'package:task_master/auth/ui/view/register_screen.dart';
import 'package:task_master/splash/ui/view/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/${SplashScreen.routeName}',
  routes: [
    GoRoute(
      path: '/${SplashScreen.routeName}',
      name: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/${LoginScreen.routeName}',
      name: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/${RegisterScreen.routeName}',
      name: RegisterScreen.routeName,
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
