import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_master/tasks/data/models/task_values.dart';

part 'simplified_task_response.freezed.dart';
part 'simplified_task_response.g.dart';

@freezed
abstract class SimplifiedTaskResponse with _$SimplifiedTaskResponse {
  const factory SimplifiedTaskResponse({
    @JsonKey(name: '_id') required String id,
    required TaskPriority priority,
    required TaskStatus status,
    required DateTime dueDate,
    required bool completed,
    required DateTime createdAt,
    String? description,
  }) = _SimplifiedTaskResponse;

  const SimplifiedTaskResponse._();

  factory SimplifiedTaskResponse.fromJson(Map<String, dynamic> json) => _$SimplifiedTaskResponseFromJson(json);

  bool get isOverdue => !completed && dueDate.toLocal().isBefore(DateTime.now());
}
