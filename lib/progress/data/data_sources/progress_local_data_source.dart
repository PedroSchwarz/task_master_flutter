import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:task_master/app/storage/app_local_storage.dart';
import 'package:task_master/progress/progress.dart';

class ProgressLocalDataSource {
  const ProgressLocalDataSource({required this.localStorage});

  @visibleForTesting
  final AppLocalStorage localStorage;

  Future<TaskProgressionSelection?> load() async {
    final value = await localStorage.read(LocalStorageKey.progressionSelection);

    if (value == null) {
      return null;
    }

    return TaskProgressionSelection.values.firstWhereOrNull((e) => e.name == value);
  }

  Future<void> save(TaskProgressionSelection selection) async {
    await localStorage.write(LocalStorageKey.progressionSelection, selection.name);
  }
}
