import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/streams.dart';
import 'package:task_master/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:task_master/auth/data/models/credentials_data.dart';
import 'package:task_master/auth/data/models/login_request.dart';
import 'package:task_master/auth/data/models/refresh_token_request.dart';
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

  static final _log = Logger('AuthRepository');

  @visibleForTesting
  final AuthRemoteDataSource authRemoteDataSource;

  @visibleForTesting
  final UserRepository userRepository;

  @visibleForTesting
  final CredentialsRepository credentialsRepository;

  ValueStream<UserData?> get currentUser => userRepository.currentUser;

  Future<void> init() async {
    await userRepository.init();
  }

  Future<LoginResult> login(String email, String password) async {
    try {
      final response = await authRemoteDataSource.login(
        LoginRequest(email: email, password: password),
      );

      await credentialsRepository.updateCredentials(
        CredentialsData(
          accessToken: response.accessToken,
          refreshToken: response.refreshToken,
        ),
      );

      await userRepository.updateUser(
        UserData(
          id: response.id,
          firstName: response.firstName,
          lastName: response.lastName,
          email: response.email,
          createdAt: response.createdAt,
        ),
      );

      return .success;
    } on DioException catch (e) {
      final code = e.response?.statusCode ?? 500;
      if (code == 404) {
        return .userNotFound;
      } else {
        return .networkError;
      }
    } catch (e) {
      return .networkError;
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
        CredentialsData(
          accessToken: response.accessToken,
          refreshToken: response.refreshToken,
        ),
      );

      await userRepository.updateUser(
        UserData(
          id: response.id,
          firstName: response.firstName,
          lastName: response.lastName,
          email: response.email,
          createdAt: response.createdAt,
        ),
      );

      return .success;
    } on DioException catch (e) {
      final code = e.response?.statusCode ?? 500;
      if (code == 409) {
        return .emailConflict;
      } else {
        return .networkError;
      }
    } catch (e) {
      return .networkError;
    }
  }

  Future<CredentialsData> refreshToken() async {
    final credentials = await credentialsRepository.getCredentials();

    if (credentials == null) {
      throw Exception('Credentials not found');
    }

    final response = await authRemoteDataSource.refreshToken(
      RefreshTokenRequest(refreshToken: credentials.refreshToken),
    );

    return CredentialsData(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
  }

  Future<void> signOut() async {
    try {
      final credentials = await credentialsRepository.getCredentials();

      if (credentials == null) {
        throw Exception('Credentials not found');
      }

      await authRemoteDataSource.signOut(
        RefreshTokenRequest(refreshToken: credentials.refreshToken),
      );
      await credentialsRepository.updateCredentials(null);
      await userRepository.updateUser(null);
    } catch (e) {
      _log.severe('Error signing out: $e', e);
    }
  }
}

enum LoginResult { success, userNotFound, networkError }

enum RegisterResult { success, emailConflict, networkError }
