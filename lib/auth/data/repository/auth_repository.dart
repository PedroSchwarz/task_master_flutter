import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task_master/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:task_master/auth/data/models/credentials_data.dart';
import 'package:task_master/auth/data/models/login_request.dart';
import 'package:task_master/auth/data/models/register_request.dart';
import 'package:task_master/auth/data/models/user_data.dart';
import 'package:task_master/auth/data/repository/credentials_repository.dart';
import 'package:task_master/auth/data/repository/user_repository.dart';

class AuthRepository {
  const AuthRepository({
    required this.authRemoteDataSource,
    required this.userRepository,
    required this.credentialsRepository,
  });

  @visibleForTesting
  final AuthRemoteDataSource authRemoteDataSource;

  @visibleForTesting
  final UserRepository userRepository;

  @visibleForTesting
  final CredentialsRepository credentialsRepository;

  UserData? get currentUser => userRepository.currentUser;

  Future<void> init() async {
    await userRepository.init();
  }

  Future<LoginResult> login(String email, String password) async {
    try {
      final response = await authRemoteDataSource.login(
        LoginRequest(email: email, password: password),
      );

      await credentialsRepository.updateCredentials(
        CredentialsData(accessToken: response.accessToken),
      );

      await userRepository.updateUser(
        UserData(
          firstName: response.firstName,
          lastName: response.lastName,
          email: response.email,
        ),
      );

      return LoginResult.success;
    } on DioException catch (e) {
      final code = e.response?.statusCode ?? 500;
      if (code == 404) {
        return LoginResult.userNotFound;
      } else {
        return LoginResult.networkError;
      }
    } catch (e) {
      return LoginResult.networkError;
    }
  }

  Future<RegisterResult> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRemoteDataSource.register(
        RegisterRequest(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
        ),
      );

      await credentialsRepository.updateCredentials(
        CredentialsData(accessToken: response.accessToken),
      );

      await userRepository.updateUser(
        UserData(
          firstName: response.firstName,
          lastName: response.lastName,
          email: response.email,
        ),
      );

      return RegisterResult.success;
    } on DioException catch (e) {
      final code = e.response?.statusCode ?? 500;
      if (code == 409) {
        return RegisterResult.emailConflict;
      } else {
        return RegisterResult.networkError;
      }
    } catch (e) {
      return RegisterResult.networkError;
    }
  }
}

enum LoginResult { success, userNotFound, networkError }

enum RegisterResult { success, emailConflict, networkError }
