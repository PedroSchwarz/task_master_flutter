import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/dashboard/data/data_sources/dashboard_local_data_source.dart';
import 'package:task_master/dashboard/data/models/groups_list_type.dart';

class DashboardRepository {
  const DashboardRepository({required this.dashboardLocalDataSource});

  static final _log = Logger('DashboardRepository');

  @visibleForTesting
  final DashboardLocalDataSource dashboardLocalDataSource;

  Future<GroupsListType> getGroupsListType({GroupsListType defaultValue = GroupsListType.list}) async {
    try {
      final type = await dashboardLocalDataSource.load();
      return type ?? defaultValue;
    } catch (e) {
      _log.severe('Error getting groups list type: $e', e);
      return defaultValue;
    }
  }

  Future<void> setGroupsListType(GroupsListType type) async {
    try {
      await dashboardLocalDataSource.save(type);
    } catch (e) {
      _log.severe('Error saving groups list type: $e', e);
    }
  }
}
