import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/notifications/data/repository/notifications_repository.dart';
import 'package:task_master/users/data/data_sources/users_remote_data_source.dart';
import 'package:task_master/users/data/models/device_token_request.dart';
import 'package:task_master/users/data/models/user_response.dart';

class UsersRepository {
  const UsersRepository({required this.authRepository, required this.usersRemoteDataSource, required this.notificationsRepository});

  static final _log = Logger('UsersRepository');

  @visibleForTesting
  final AuthRepository authRepository;

  @visibleForTesting
  final UsersRemoteDataSource usersRemoteDataSource;

  @visibleForTesting
  final NotificationsRepository notificationsRepository;

  Future<List<UserResponse>> getUsers() async {
    return usersRemoteDataSource.fetchAll();
  }

  Future<void> updateDeviceToken() async {
    try {
      final token = await notificationsRepository.getToken();

      if (token == null) {
        return;
      }

      await usersRemoteDataSource.updateDeviceToken(DeviceTokenRequest(token: token));
      await notificationsRepository.subscribeToTopic('user_${authRepository.currentUser.value!.id}');
    } catch (e) {
      _log.severe('Error updating users device token: $e', e);
    }
  }

  Future<void> removeNotifications() async {
    try {
      await notificationsRepository.unsubscribeFromTopic('user_${authRepository.currentUser.value!.id}');
    } catch (e) {
      _log.severe('Error removing notifications for user: $e', e);
    }
  }
}
