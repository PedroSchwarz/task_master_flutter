import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_group_request.freezed.dart';
part 'update_group_request.g.dart';

@freezed
abstract class UpdateGroupRequest with _$UpdateGroupRequest {
  const factory UpdateGroupRequest({required String name, required String description, required List<String> members}) = _UpdateGroupRequest;

  factory UpdateGroupRequest.fromJson(Map<String, dynamic> json) => _$UpdateGroupRequestFromJson(json);
}
