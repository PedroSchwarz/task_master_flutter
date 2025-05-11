import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/app/ui/navigation.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/comments/data/data_sources/comments_remote_data_source.dart';
import 'package:task_master/comments/data/repository/comments_repository.dart';
import 'package:task_master/dashboard/ui/cubit/dashboard_cubit.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/splash/splash.dart';
import 'package:task_master/tasks/tasks.dart';
import 'package:task_master/users/users.dart';

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
    return const BuildConfigurations(baseUrl: 'http://localhost:3000/', environment: Environment.production);
  }

  @override
  Future<void> setup() async {
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

    getIt
      ..registerSingleton(appStorage)
      ..registerSingleton(buildConfigurations)
      ..registerSingleton(CredentialsLocalDataSource(localStorage: getIt()))
      ..registerSingleton(UserLocalDataSource(localStorage: getIt()))
      ..registerSingleton(CredentialsRepository(credentialsLocalDataSource: getIt()))
      ..registerSingleton(UserRepository(userLocalDataSource: getIt()))
      ..registerSingleton(createAuthenticatedDio(baseUrl: buildConfigurations.baseUrl, credentialsRepository: getIt()))
      ..registerSingleton(createDio(baseUrl: buildConfigurations.baseUrl), instanceName: BaseServiceLocators.noAuthDio)
      ..registerSingleton(AuthRemoteDataSource(getIt(instanceName: BaseServiceLocators.noAuthDio)))
      ..registerSingleton(AuthRepository(authRemoteDataSource: getIt(), userRepository: getIt(), credentialsRepository: getIt()))
      ..registerSingleton(createRouter(authRepository: getIt()))
      ..registerSingleton(SplashRepository(authRepository: getIt()))
      ..registerFactory(() => SplashCubit(splashRepository: getIt()))
      ..registerFactory(() => LoginCubit(authRepository: getIt()))
      ..registerFactory(() => RegisterCubit(authRepository: getIt()))
      ..registerSingleton(UsersRemoteDataSource(getIt()))
      ..registerSingleton(UsersRepository(usersRemoteDataSource: getIt()))
      ..registerSingleton(InvitesRemoteDataSource(getIt()))
      ..registerSingleton(InvitesRepository(invitesRemoteDataSource: getIt()))
      ..registerSingleton(GroupsRemoteDataSource(getIt()))
      ..registerSingleton(GroupsRepository(groupsRemoteDataSource: getIt()))
      ..registerFactory(() => CreateGroupCubit(groupsRepository: getIt(), invitesRepository: getIt(), usersRepository: getIt()))
      ..registerFactory(() => DashboardCubit(authRepository: getIt(), groupsRepository: getIt(), invitesRepository: getIt()))
      ..registerFactory(() => InvitesCubit(invitesRepository: getIt()))
      ..registerSingleton(TasksRemoteDataSource(getIt()))
      ..registerSingleton(TasksRepository(tasksRemoteDataSource: getIt()))
      ..registerSingleton(CommentsRemoteDataSource(getIt()))
      ..registerSingleton(CommentsRepository(commentsRemoteDataSource: getIt()))
      ..registerFactory(
        () => GroupDetailsCubit(authRepository: getIt(), groupsRepository: getIt(), tasksRepository: getIt(), invitesRepository: getIt()),
      )
      ..registerFactory(() => CreateTaskCubit(groupsRepository: getIt(), tasksRepository: getIt()))
      ..registerFactory(() => TaskDetailsCubit(authRepository: getIt(), tasksRepository: getIt(), commentsRepository: getIt()));
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
