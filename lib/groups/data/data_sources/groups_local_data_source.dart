import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/groups.dart';

class GroupsLocalDataSource {
  const GroupsLocalDataSource({required this.localStorage});

  @visibleForTesting
  final AppLocalStorage localStorage;

  Future<void> saveListView(TaskListView listView) async {
    return localStorage.write(LocalStorageKey.tasksListView, listView.name);
  }

  Future<TaskListView> loadListView() async {
    final listView = await localStorage.read(LocalStorageKey.tasksListView);

    if (listView == null) {
      return TaskListView.calendar;
    }

    return TaskListView.values.firstWhereOrNull((view) => view.name == listView) ?? TaskListView.calendar;
  }
}
