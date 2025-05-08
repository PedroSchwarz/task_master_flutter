import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_master/tasks/data/models/task_values.dart';

part 'update_task_request.freezed.dart';
part 'update_task_request.g.dart';

@freezed
abstract class UpdateTaskRequest with _$UpdateTaskRequest {
  const factory UpdateTaskRequest({
    required String title,
    required DateTime dueDate,
    required TaskPriority priority,
    required TaskStatus status,
    required bool completed,
    required List<String> assignedTo,
    @JsonKey(includeIfNull: false) String? description,
  }) = _UpdateTaskRequest;

  factory UpdateTaskRequest.fromJson(Map<String, dynamic> json) => _$UpdateTaskRequestFromJson(json);
}
