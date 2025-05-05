import 'package:flutter/foundation.dart';
import 'package:task_master/tasks/tasks.dart';

class TasksRepository {
  const TasksRepository({required this.tasksRemoteDataSource});

  @visibleForTesting
  final TasksRemoteDataSource tasksRemoteDataSource;

  Future<List<TaskResponse>> fetchAll(String groupId) async {
    return tasksRemoteDataSource.fetchAll(groupId);
  }

  Future<String> create(CreateTaskRequest request) async {
    return tasksRemoteDataSource.create(request);
  }
}
