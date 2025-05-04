import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_master/users/users.dart';

part 'invite_response.freezed.dart';
part 'invite_response.g.dart';

@freezed
abstract class InviteResponse with _$InviteResponse {
  const factory InviteResponse({
    required UserResponse from,
    required InviteGroupResponse group,
    required DateTime createdAt,
  }) = _InviteResponse;

  factory InviteResponse.fromJson(Map<String, dynamic> json) =>
      _$InviteResponseFromJson(json);
}

@freezed
abstract class InviteGroupResponse with _$InviteGroupResponse {
  const factory InviteGroupResponse({required String name}) =
      _InviteGroupResponse;

  factory InviteGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$InviteGroupResponseFromJson(json);
}
