import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_master/tasks/data/models/task_values.dart';

part 'create_task_request.freezed.dart';
part 'create_task_request.g.dart';

@freezed
abstract class CreateTaskRequest with _$CreateTaskRequest {
  const factory CreateTaskRequest({
    required String title,
    required DateTime dueDate,
    required String group,
    @JsonKey(includeIfNull: false) String? description,
    @JsonKey(includeIfNull: false) TaskPriority? priority,
    @JsonKey(includeIfNull: false) TaskStatus? status,
    @JsonKey(includeIfNull: false) List<String>? assignedTo,
  }) = _CreateTaskRequest;

  factory CreateTaskRequest.fromJson(Map<String, dynamic> json) => _$CreateTaskRequestFromJson(json);
}
