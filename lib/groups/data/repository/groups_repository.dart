import 'package:flutter/foundation.dart';
import 'package:task_master/groups/groups.dart';

class GroupsRepository {
  const GroupsRepository({required this.groupsRemoteDataSource, required this.groupsLocalDataSource});

  @visibleForTesting
  final GroupsRemoteDataSource groupsRemoteDataSource;

  @visibleForTesting
  final GroupsLocalDataSource groupsLocalDataSource;

  Future<List<GroupResponse>> getGroups() async {
    return groupsRemoteDataSource.fetchAll();
  }

  Future<GroupResponse> getGroupById(String id) async {
    return groupsRemoteDataSource.fetchById(id);
  }

  Future<void> saveTasksListView(TaskListView listView) async {
    return groupsLocalDataSource.saveListView(listView);
  }

  Future<TaskListView> loadTasksListView() async {
    return groupsLocalDataSource.loadListView();
  }

  Future<String> createGroup(CreateGroupRequest request) async {
    return groupsRemoteDataSource.create(request);
  }

  Future<void> addMemberToGroup(String id) async {
    return groupsRemoteDataSource.addMember(id);
  }

  Future<void> leaveGroup(String id) async {
    return groupsRemoteDataSource.leave(id);
  }

  Future<void> updateGroup(UpdateGroupRequest request, {required String id}) async {
    return groupsRemoteDataSource.update(id, request);
  }

  Future<void> deleteGroup(String id) async {
    return groupsRemoteDataSource.delete(id);
  }
}
