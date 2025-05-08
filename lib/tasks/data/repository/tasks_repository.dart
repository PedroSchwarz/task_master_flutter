import 'package:flutter/foundation.dart';
import 'package:task_master/tasks/data/models/update_task_request.dart';
import 'package:task_master/tasks/tasks.dart';

class TasksRepository {
  const TasksRepository({required this.tasksRemoteDataSource});

  @visibleForTesting
  final TasksRemoteDataSource tasksRemoteDataSource;

  Future<List<TaskResponse>> fetchAll(String groupId) async {
    return tasksRemoteDataSource.fetchAll(groupId);
  }

  Future<TaskResponse> fetchById(String id) async {
    return tasksRemoteDataSource.fetchById(id);
  }

  Future<void> create(CreateTaskRequest request) async {
    return tasksRemoteDataSource.create(request);
  }

  Future<void> update(UpdateTaskRequest request, {required String id}) async {
    return tasksRemoteDataSource.update(id, request);
  }

  Future<void> delete(String id) async {
    return tasksRemoteDataSource.delete(id);
  }
}
