import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/groups.dart';

class GroupsLocalDataSource {
  const GroupsLocalDataSource({required this.localStorage});

  @visibleForTesting
  final AppLocalStorage localStorage;

  Future<void> saveListView(TaskListView listView) async {
    return localStorage.write(.tasksListView, listView.name);
  }

  Future<TaskListView> loadListView() async {
    final listView = await localStorage.read(.tasksListView);

    if (listView == null) {
      return .calendar;
    }

    return .values.firstWhereOrNull(
          (view) => view.name == listView,
        ) ??
        .calendar;
  }
}
