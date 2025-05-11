// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) =>
    _CommentResponse(
      id: json['_id'] as String,
      message: json['message'] as String,
      task: json['task'] as String,
      owner: UserResponse.fromJson(json['owner'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CommentResponseToJson(_CommentResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'message': instance.message,
      'task': instance.task,
      'owner': instance.owner,
      'createdAt': instance.createdAt.toIso8601String(),
    };
