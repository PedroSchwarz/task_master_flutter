import 'package:flutter/foundation.dart';
import 'package:task_master/groups/groups.dart';

class GroupsRepository {
  const GroupsRepository({required this.groupsRemoteDataSource});

  @visibleForTesting
  final GroupsRemoteDataSource groupsRemoteDataSource;

  Future<List<GroupResponse>> getGroups() async {
    return groupsRemoteDataSource.fetchAll();
  }

  Future<GroupResponse> getGroupById(String id) async {
    return groupsRemoteDataSource.fetchById(id);
  }

  Future<String> createGroup({required String name, required String description}) async {
    return groupsRemoteDataSource.create(CreateGroupRequest(name: name, description: description));
  }

  Future<void> updateGroup(UpdateGroupRequest request, {required String id}) async {
    return groupsRemoteDataSource.update(id, request);
  }

  Future<void> deleteGroup(String id) async {
    return groupsRemoteDataSource.delete(id);
  }
}
