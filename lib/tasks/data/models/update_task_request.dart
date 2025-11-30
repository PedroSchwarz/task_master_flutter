import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_master/tasks/data/models/task_values.dart';
import 'package:task_master/tasks/tasks.dart';

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
    required List<UpdateTaskChecklistItem> checklist,
    required bool recurring,
    @JsonKey(includeIfNull: false) String? description,
    @JsonKey(includeIfNull: false) TaskRecurrence? recurrencePattern,
    @JsonKey(includeIfNull: false) DateTime? recurrenceEndDate,
  }) = _UpdateTaskRequest;

  factory UpdateTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTaskRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => map(
    (value) => _$UpdateTaskRequestToJson(value),
  );
}

@freezed
abstract class UpdateTaskChecklistItem with _$UpdateTaskChecklistItem {
  const factory UpdateTaskChecklistItem({
    required String title,
    required TaskChecklistItemStatus status,
    required int order,
  }) = _UpdateTaskChecklistItem;

  factory UpdateTaskChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$UpdateTaskChecklistItemFromJson(json);
}
