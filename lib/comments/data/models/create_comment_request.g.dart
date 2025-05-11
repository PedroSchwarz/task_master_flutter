// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_comment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateCommentRequest _$CreateCommentRequestFromJson(
  Map<String, dynamic> json,
) => _CreateCommentRequest(
  message: json['message'] as String,
  task: json['task'] as String,
);

Map<String, dynamic> _$CreateCommentRequestToJson(
  _CreateCommentRequest instance,
) => <String, dynamic>{'message': instance.message, 'task': instance.task};
