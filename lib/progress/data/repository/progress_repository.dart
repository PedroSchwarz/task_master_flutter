import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:task_master/progress/progress.dart';

class ProgressRepository {
  const ProgressRepository({required this.progressLocalDataSource});

  static final _log = Logger('ProgressRepository');

  @visibleForTesting
  final ProgressLocalDataSource progressLocalDataSource;

  Future<TaskProgressionSelection> getProgressionSelection({
    TaskProgressionSelection defaultValue = .assigned,
  }) async {
    try {
      final selection = await progressLocalDataSource.load();
      return selection ?? defaultValue;
    } catch (e) {
      _log.severe('Error getting progression selection: $e', e);
      return defaultValue;
    }
  }

  Future<void> setProgressionSelection(
    TaskProgressionSelection selection,
  ) async {
    try {
      await progressLocalDataSource.save(selection);
    } catch (e) {
      _log.severe('Error saving progression selection: $e', e);
    }
  }
}
