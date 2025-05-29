// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardState _$DashboardStateFromJson(
  Map<String, dynamic> json,
) => _DashboardState(
  isLoading: json['isLoading'] as bool,
  groupsListType: $enumDecode(_$GroupsListTypeEnumMap, json['groupsListType']),
  groups:
      (json['groups'] as List<dynamic>)
          .map((e) => GroupResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
  invites:
      (json['invites'] as List<dynamic>)
          .map((e) => InviteResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
  progression:
      (json['progression'] as List<dynamic>)
          .map(
            (e) =>
                e == null
                    ? null
                    : WeeklyTaskProgression.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  selection: $enumDecode(_$TaskProgressionSelectionEnumMap, json['selection']),
  isRefreshing: json['isRefreshing'] as bool,
);

Map<String, dynamic> _$DashboardStateToJson(_DashboardState instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'groupsListType': _$GroupsListTypeEnumMap[instance.groupsListType]!,
      'groups': instance.groups,
      'invites': instance.invites,
      'progression': instance.progression,
      'selection': _$TaskProgressionSelectionEnumMap[instance.selection]!,
      'isRefreshing': instance.isRefreshing,
    };

const _$GroupsListTypeEnumMap = {
  GroupsListType.list: 'list',
  GroupsListType.grid: 'grid',
};

const _$TaskProgressionSelectionEnumMap = {
  TaskProgressionSelection.assigned: 'assigned',
  TaskProgressionSelection.owned: 'owned',
};
