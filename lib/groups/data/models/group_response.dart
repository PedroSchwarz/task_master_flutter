import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_master/users/data/models/user_response.dart';

part 'group_response.freezed.dart';
part 'group_response.g.dart';

@freezed
abstract class GroupResponse with _$GroupResponse {
  const factory GroupResponse({
    @JsonKey(name: '_id') required String id,
    required String name,
    required String description,
    required DateTime createdAt,
    required UserResponse owner,
    required List<UserResponse> members,
    required int? color,
  }) = _GroupResponse;

  factory GroupResponse.fromJson(Map<String, dynamic> json) => _$GroupResponseFromJson(json);
}
