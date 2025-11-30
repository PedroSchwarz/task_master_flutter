import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/dashboard/data/data_sources/dashboard_local_data_source.dart';
import 'package:task_master/dashboard/data/models/groups_list_type.dart';

class DashboardRepository {
  const DashboardRepository({required this.dashboardLocalDataSource});

  static final _log = Logger('DashboardRepository');

  @visibleForTesting
  final DashboardLocalDataSource dashboardLocalDataSource;

  Future<GroupsListType> getGroupsListType({
    GroupsListType defaultValue = .list,
  }) async {
    try {
      final type = await dashboardLocalDataSource.loadGroupsListType();
      return type ?? defaultValue;
    } catch (e) {
      _log.severe('Error getting groups list type: $e', e);
      return defaultValue;
    }
  }

  Future<void> setGroupsListType(GroupsListType type) async {
    try {
      await dashboardLocalDataSource.saveGroupsListType(type);
    } catch (e) {
      _log.severe('Error saving groups list type: $e', e);
    }
  }

  Future<bool> getShowingProgression() async {
    try {
      return await dashboardLocalDataSource.loadShowingProgression();
    } catch (e) {
      _log.severe('Error getting showing progression: $e', e);
      return true;
    }
  }

  Future<void> setShowingProgression(bool value) async {
    try {
      await dashboardLocalDataSource.saveShowingProgression(value);
    } catch (e) {
      _log.severe('Error saving showing progression: $e', e);
    }
  }

  Future<bool> getShowingHighlights() async {
    try {
      return await dashboardLocalDataSource.loadShowingHighlights();
    } catch (e) {
      _log.severe('Error getting showing highlights: $e', e);
      return true;
    }
  }

  Future<void> setShowingHighlights(bool value) async {
    try {
      await dashboardLocalDataSource.saveShowingHighlights(value);
    } catch (e) {
      _log.severe('Error saving showing highlights: $e', e);
    }
  }
}
