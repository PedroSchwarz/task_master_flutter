import 'package:flutter/foundation.dart';
import 'package:task_master/users/data/data_sources/users_remote_data_source.dart';
import 'package:task_master/users/data/models/user_response.dart';

class UsersRepository {
  const UsersRepository({required this.usersRemoteDataSource});

  @visibleForTesting
  final UsersRemoteDataSource usersRemoteDataSource;

  Future<List<UserResponse>> getUsers() async {
    return usersRemoteDataSource.fetchAll();
  }
}
