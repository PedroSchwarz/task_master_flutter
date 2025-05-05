import 'package:flutter/foundation.dart';
import 'package:task_master/groups/data/data_sources/groups_remote_data_source.dart';
import 'package:task_master/groups/data/models/create_group_request.dart';
import 'package:task_master/groups/data/models/group_response.dart';

class GroupsRepository {
  const GroupsRepository({required this.groupsRemoteDataSource});

  @visibleForTesting
  final GroupsRemoteDataSource groupsRemoteDataSource;

  Future<List<GroupResponse>> getGroups() async {
    return await groupsRemoteDataSource.fetchAll();
  }

  Future<String> createGroup({required String name, required String description}) async {
    return await groupsRemoteDataSource.create(CreateGroupRequest(name: name, description: description));
  }
}
