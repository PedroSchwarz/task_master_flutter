import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/dashboard/ui/view/dashboard_screen.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/splash/ui/view/splash_screen.dart';
import 'package:task_master/tasks/tasks.dart';

GoRouter createRouter({required AuthRepository authRepository}) {
  List<String> authWhiteList = [SplashScreen.routeName, LoginScreen.routeName, RegisterScreen.routeName];

  final router = GoRouter(
    initialLocation: '/${SplashScreen.routeName}',
    refreshListenable: GoRouterRefreshStreamListenable(authRepository.currentUser.distinct()),
    redirect: (context, state) {
      if (authWhiteList.contains(state.topRoute?.name)) {
        return null;
      }

      if (authRepository.currentUser.value == null) {
        return '/${LoginScreen.routeName}';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/${SplashScreen.routeName}', name: SplashScreen.routeName, builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/${LoginScreen.routeName}', name: LoginScreen.routeName, builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/${RegisterScreen.routeName}', name: RegisterScreen.routeName, builder: (context, state) => const RegisterScreen()),
      GoRoute(
        path: '/${DashboardScreen.routeName}',
        name: DashboardScreen.routeName,
        builder: (context, state) => const DashboardScreen(),
        routes: [
          GoRoute(path: '/${CreateGroupScreen.routeName}', name: CreateGroupScreen.routeName, builder: (context, state) => const CreateGroupScreen()),
          GoRoute(path: '/${InvitesScreen.routeName}', name: InvitesScreen.routeName, builder: (context, state) => const InvitesScreen()),
          GoRoute(
            path: '/${GroupDetailsScreen.routeName}/:id',
            name: GroupDetailsScreen.routeName,
            builder: (context, state) => GroupDetailsScreen(id: state.pathParameters['id'] ?? '', name: state.uri.queryParameters['name'] ?? ''),
            routes: [
              GoRoute(
                path: '/${CreateTaskScreen.routeName}',
                name: CreateTaskScreen.routeName,
                builder: (context, state) => CreateTaskScreen(groupId: state.pathParameters['id'] ?? '', taskId: state.uri.queryParameters['taskId']),
              ),
            ],
          ),
          GoRoute(
            path: '/${TaskDetailsScreen.routeName}/:id',
            name: TaskDetailsScreen.routeName,
            builder: (context, state) => TaskDetailsScreen(id: state.pathParameters['id'] ?? ''),
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
