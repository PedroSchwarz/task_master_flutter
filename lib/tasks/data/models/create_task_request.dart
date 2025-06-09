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
    required List<CreateTaskChecklistItem> checklist,
    required bool recurring,
    @JsonKey(includeIfNull: false) String? description,
    @JsonKey(includeIfNull: false) TaskPriority? priority,
    @JsonKey(includeIfNull: false) TaskStatus? status,
    @JsonKey(includeIfNull: false) List<String>? assignedTo,
    @JsonKey(includeIfNull: false) TaskRecurrence? recurrencePattern,
    @JsonKey(includeIfNull: false) DateTime? recurrenceEndDate,
  }) = _CreateTaskRequest;

  factory CreateTaskRequest.fromJson(Map<String, dynamic> json) => _$CreateTaskRequestFromJson(json);
}

@freezed
abstract class CreateTaskChecklistItem with _$CreateTaskChecklistItem {
  const factory CreateTaskChecklistItem({required String title, required int order}) = _CreateTaskChecklistItem;

  factory CreateTaskChecklistItem.fromJson(Map<String, dynamic> json) => _$CreateTaskChecklistItemFromJson(json);
}
