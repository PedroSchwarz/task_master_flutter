import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/dashboard/data/models/groups_list_type.dart';

class DashboardLocalDataSource {
  const DashboardLocalDataSource({required this.localStorage});

  @visibleForTesting
  final AppLocalStorage localStorage;

  Future<GroupsListType?> loadGroupsListType() async {
    final value = await localStorage.read(.groupsListType);

    if (value == null) {
      return null;
    }

    return .values.firstWhereOrNull((e) => e.name == value);
  }

  Future<void> saveGroupsListType(GroupsListType type) async {
    await localStorage.write(.groupsListType, type.name);
  }

  Future<bool> loadShowingProgression() async {
    final value = await localStorage.read(.showProgression);

    if (value == null) {
      return true;
    }

    return bool.tryParse(value) ?? true;
  }

  Future<void> saveShowingProgression(bool value) async {
    await localStorage.write(.showProgression, value.toString());
  }

  Future<bool> loadShowingHighlights() async {
    final value = await localStorage.read(.showHighlights);

    if (value == null) {
      return true;
    }

    return bool.tryParse(value) ?? true;
  }

  Future<void> saveShowingHighlights(bool value) async {
    await localStorage.write(.showHighlights, value.toString());
  }
}
