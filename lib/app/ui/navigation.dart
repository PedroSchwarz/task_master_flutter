import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/dashboard/dashboard.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/progress/progress.dart';
import 'package:task_master/splash/ui/view/splash_screen.dart';
import 'package:task_master/tasks/tasks.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter({required AuthRepository authRepository}) {
  List<String> authWhiteList = [SplashScreen.routeName, LoginScreen.routeName, RegisterScreen.routeName];

  final router = GoRouter(
    navigatorKey: navigatorKey,
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
      GoRoute(
        path: '/${LoginScreen.routeName}',
        name: LoginScreen.routeName,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const LoginScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(path: '/${RegisterScreen.routeName}', name: RegisterScreen.routeName, builder: (context, state) => const RegisterScreen()),
      GoRoute(
        path: '/${DashboardScreen.routeName}',
        name: DashboardScreen.routeName,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const DashboardScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
        routes: [
          GoRoute(
            path: '/${CreateGroupScreen.routeName}',
            name: CreateGroupScreen.routeName,
            builder: (context, state) => CreateGroupScreen(id: state.uri.queryParameters['id']),
          ),
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
              GoRoute(
                path: '/${TaskDetailsScreen.routeName}/:taskId',
                name: TaskDetailsScreen.routeName,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: TaskDetailsScreen(id: state.pathParameters['taskId'] ?? ''),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.decelerate;

                      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                      return SlideTransition(position: animation.drive(tween), child: child);
                    },
                  );
                },
              ),
            ],
          ),
          GoRoute(path: '/${ProgressionScreen.routeName}', name: ProgressionScreen.routeName, builder: (context, state) => const ProgressionScreen()),
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
