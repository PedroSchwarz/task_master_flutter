import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/app/ui/navigation.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/comments/comments.dart';
import 'package:task_master/dashboard/dashboard.dart';
import 'package:task_master/firebase_options.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/notifications/notifications.dart';
import 'package:task_master/progress/progress.dart';
import 'package:task_master/splash/splash.dart';
import 'package:task_master/tasks/tasks.dart';
import 'package:task_master/users/users.dart';
import 'package:uuid/uuid.dart';

final getIt = GetIt.instance;

sealed class BaseServiceLocators {
  const BaseServiceLocators();

  static const String noAuthDio = 'no_auth_dio';

  BuildConfigurations get buildConfigurations;

  @mustCallSuper
  Future<void> setup();
}

class Locators extends BaseServiceLocators {
  @override
  BuildConfigurations get buildConfigurations {
    return const BuildConfigurations(baseUrl: 'https://task-master-api-beej.onrender.com/', environment: Environment.production);
  }

  @override
  Future<void> setup() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    getIt.registerSingleton(
      const FlutterSecureStorage(
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
        aOptions: AndroidOptions(sharedPreferencesName: 'task_master_secure_storage', encryptedSharedPreferences: true),
      ),
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerSingleton(sharedPreferences);

    final appStorage = AppLocalStorage(secureStorage: getIt(), sharedPreferences: getIt());
    await appStorage.create();

    final notificationsRepository = NotificationsRepository(
      firebaseMessaging: FirebaseMessaging.instance,
      localNotifications: FlutterLocalNotificationsPlugin(),
    );
    await notificationsRepository.initialize();

    getIt
      ..registerSingleton(appStorage)
      ..registerSingleton(buildConfigurations)
      ..registerSingleton(const Uuid())
      ..registerSingleton(CredentialsLocalDataSource(localStorage: getIt()))
      ..registerSingleton(UserLocalDataSource(localStorage: getIt()))
      ..registerSingleton(CredentialsRepository(credentialsLocalDataSource: getIt()))
      ..registerSingleton(UserRepository(userLocalDataSource: getIt()))
      ..registerSingleton(createAuthenticatedDio(baseUrl: buildConfigurations.baseUrl, credentialsRepository: getIt()))
      ..registerSingleton(createDio(baseUrl: buildConfigurations.baseUrl), instanceName: BaseServiceLocators.noAuthDio)
      ..registerSingleton(WebsocketClient(configurations: getIt()))
      ..registerSingleton(AuthRemoteDataSource(getIt(instanceName: BaseServiceLocators.noAuthDio)))
      ..registerSingleton(AuthRepository(authRemoteDataSource: getIt(), userRepository: getIt(), credentialsRepository: getIt()))
      ..registerSingleton(createRouter(authRepository: getIt()))
      ..registerSingleton(notificationsRepository)
      ..registerSingleton(SplashRepository(authRepository: getIt()))
      ..registerFactory(() => SplashCubit(splashRepository: getIt()))
      ..registerFactory(() => LoginCubit(authRepository: getIt()))
      ..registerFactory(() => RegisterCubit(authRepository: getIt()))
      ..registerSingleton(UsersRemoteDataSource(getIt()))
      ..registerSingleton(UsersRepository(authRepository: getIt(), usersRemoteDataSource: getIt(), notificationsRepository: getIt()))
      ..registerSingleton(InvitesRemoteDataSource(getIt()))
      ..registerSingleton(InvitesRepository(invitesRemoteDataSource: getIt()))
      ..registerSingleton(GroupsRemoteDataSource(getIt()))
      ..registerSingleton(GroupsLocalDataSource(localStorage: getIt()))
      ..registerSingleton(GroupsWebsocket(client: getIt())..listen())
      ..registerSingleton(GroupsRepository(groupsRemoteDataSource: getIt(), groupsLocalDataSource: getIt()))
      ..registerFactory(
        () => CreateGroupCubit(authRepository: getIt(), groupsRepository: getIt(), invitesRepository: getIt(), usersRepository: getIt()),
      )
      ..registerFactory(() => InvitesCubit(invitesRepository: getIt(), groupsRepository: getIt(), groupsWebsocket: getIt()))
      ..registerSingleton(TasksRemoteDataSource(getIt()))
      ..registerSingleton(TasksRepository(tasksRemoteDataSource: getIt()))
      ..registerSingleton(TasksWebsocket(client: getIt())..listen())
      ..registerSingleton(CommentsRemoteDataSource(getIt()))
      ..registerSingleton(CommentsRepository(commentsRemoteDataSource: getIt()))
      ..registerSingleton(CommentsWebsocket(client: getIt())..listen())
      ..registerFactory(
        () => GroupDetailsCubit(
          authRepository: getIt(),
          groupsRepository: getIt(),
          tasksRepository: getIt(),
          invitesRepository: getIt(),
          groupsWebsocket: getIt(),
          tasksWebsocket: getIt(),
        ),
      )
      ..registerFactory(() => CreateTaskCubit(groupsRepository: getIt(), tasksRepository: getIt(), uuid: getIt()))
      ..registerFactory(
        () => TaskDetailsCubit(
          authRepository: getIt(),
          tasksRepository: getIt(),
          commentsRepository: getIt(),
          tasksWebsocket: getIt(),
          groupsWebsocket: getIt(),
          commentsWebsocket: getIt(),
        ),
      )
      ..registerSingleton(ProgressLocalDataSource(localStorage: getIt()))
      ..registerSingleton(ProgressRepository(progressLocalDataSource: getIt()))
      ..registerSingleton(GetUsersCurrentWeekUseCase(authRepository: getIt()))
      ..registerSingleton(GetTasksProgressionForWeeksUseCase(authRepository: getIt(), tasksRepository: getIt(), getUsersCurrentWeekUseCase: getIt()))
      ..registerSingleton(DashboardLocalDataSource(localStorage: getIt()))
      ..registerSingleton(DashboardRepository(dashboardLocalDataSource: getIt()))
      ..registerFactory(
        () => DashboardCubit(
          authRepository: getIt(),
          usersRepository: getIt(),
          dashboardRepository: getIt(),
          groupsRepository: getIt(),
          tasksRepository: getIt(),
          invitesRepository: getIt(),
          progressRepository: getIt(),
          getTasksProgressionForWeeksUseCase: getIt(),
          groupsWebsocket: getIt(),
          tasksWebsocket: getIt(),
        ),
      )
      ..registerFactory(() => ProgressionCubit(progressRepository: getIt(), getTasksProgressionForWeeksUseCase: getIt()));
  }

  Dio createDio({required String baseUrl}) {
    return Dio(BaseOptions(baseUrl: baseUrl));
  }

  Dio createAuthenticatedDio({required String baseUrl, required CredentialsRepository credentialsRepository}) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    final authInterceptor = AuthInterceptor(credentialsRepository: credentialsRepository, dio: dio);
    dio.interceptors.add(authInterceptor);
    return dio;
  }
}
