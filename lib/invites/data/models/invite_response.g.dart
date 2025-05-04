// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InviteResponse _$InviteResponseFromJson(Map<String, dynamic> json) =>
    _InviteResponse(
      from: UserResponse.fromJson(json['from'] as Map<String, dynamic>),
      group: InviteGroupResponse.fromJson(
        json['group'] as Map<String, dynamic>,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$InviteResponseToJson(_InviteResponse instance) =>
    <String, dynamic>{
      'from': instance.from,
      'group': instance.group,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_InviteGroupResponse _$InviteGroupResponseFromJson(Map<String, dynamic> json) =>
    _InviteGroupResponse(name: json['name'] as String);

Map<String, dynamic> _$InviteGroupResponseToJson(
  _InviteGroupResponse instance,
) => <String, dynamic>{'name': instance.name};
