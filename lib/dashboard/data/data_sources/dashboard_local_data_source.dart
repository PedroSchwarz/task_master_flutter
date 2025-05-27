import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/dashboard/data/models/groups_list_type.dart';

class DashboardLocalDataSource {
  const DashboardLocalDataSource({required this.localStorage});

  @visibleForTesting
  final AppLocalStorage localStorage;

  Future<GroupsListType?> load() async {
    final value = await localStorage.read(LocalStorageKey.groupsListType);

    if (value == null) {
      return null;
    }

    return GroupsListType.values.firstWhereOrNull((e) => e.name == value);
  }

  Future<void> save(GroupsListType type) async {
    await localStorage.write(LocalStorageKey.groupsListType, type.name);
  }
}
