// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateGroupRequest _$CreateGroupRequestFromJson(Map<String, dynamic> json) =>
    _CreateGroupRequest(
      name: json['name'] as String,
      description: json['description'] as String,
      color: (json['color'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreateGroupRequestToJson(_CreateGroupRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'color': instance.color,
    };
