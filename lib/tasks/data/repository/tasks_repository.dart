import 'package:flutter/foundation.dart';
import 'package:task_master/tasks/data/models/update_task_request.dart';
import 'package:task_master/tasks/tasks.dart';

class TasksRepository {
  const TasksRepository({required this.tasksRemoteDataSource});

  @visibleForTesting
  final TasksRemoteDataSource tasksRemoteDataSource;

  Future<List<TaskResponse>> getAll(String groupId) async {
    return tasksRemoteDataSource.fetchAll(groupId);
  }

  Future<List<SimplifiedTaskResponse>> getAllAssigned() async {
    return tasksRemoteDataSource.fetchAllAssigned();
  }

  Future<List<SimplifiedTaskResponse>> getAllOwned() async {
    return tasksRemoteDataSource.fetchAllOwned();
  }

  Future<TaskResponse> getById(String id) async {
    return tasksRemoteDataSource.fetchById(id);
  }

  Future<String> create(CreateTaskRequest request) async {
    return tasksRemoteDataSource.create(request);
  }

  Future<void> update(UpdateTaskRequest request, {required String id}) async {
    return tasksRemoteDataSource.update(id, request);
  }

  Future<void> delete(String id) async {
    return tasksRemoteDataSource.delete(id);
  }
}
