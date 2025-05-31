import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:task_master/users/users.dart';

part 'comment_response.freezed.dart';
part 'comment_response.g.dart';

@freezed
abstract class CommentResponse with _$CommentResponse {
  const factory CommentResponse({
    @JsonKey(name: '_id') required String id,
    required String message,
    required String task,
    required UserResponse owner,
    required DateTime createdAt,
  }) = _CommentResponse;

  const CommentResponse._();

  factory CommentResponse.fromJson(Map<String, dynamic> json) => _$CommentResponseFromJson(json);

  String get formattedCreatedAt {
    final localDate = createdAt.toLocal();
    final formatter = DateFormat('EEEE, d MMMM - hh:mm a');

    return formatter.format(localDate);
  }
}
