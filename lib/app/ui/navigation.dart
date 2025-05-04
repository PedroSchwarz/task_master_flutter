import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/dashboard/ui/view/dashboard_screen.dart';
import 'package:task_master/groups/ui/view/create_group_screen.dart';
import 'package:task_master/splash/ui/view/splash_screen.dart';

GoRouter createRouter({required AuthRepository authRepository}) {
  final router = GoRouter(
    initialLocation: '/${SplashScreen.routeName}',
    refreshListenable: GoRouterRefreshStreamListenable(
      authRepository.currentUser.distinct(),
    ),
    redirect: (context, state) {
      if (state.topRoute?.name == SplashScreen.routeName) {
        return null;
      }

      if (authRepository.currentUser.value == null) {
        return '/${LoginScreen.routeName}';
      }
      return null;
    },
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
      GoRoute(
        path: '/${DashboardScreen.routeName}',
        name: DashboardScreen.routeName,
        builder: (context, state) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: '/${CreateGroupScreen.routeName}',
            name: CreateGroupScreen.routeName,
            builder: (context, state) => const CreateGroupScreen(),
          ),
        ],
      ),
    ],
  );
  return router;
}

class GoRouterRefreshStreamListenable extends ChangeNotifier {
  GoRouterRefreshStreamListenable(Stream<Object?> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((value) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
