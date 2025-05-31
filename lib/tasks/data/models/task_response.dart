import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:task_master/tasks/data/models/task_values.dart';
import 'package:task_master/users/users.dart';

part 'task_response.freezed.dart';
part 'task_response.g.dart';

@freezed
abstract class TaskResponse with _$TaskResponse {
  const factory TaskResponse({
    @JsonKey(name: '_id') required String id,
    required String title,
    required TaskPriority priority,
    required TaskStatus status,
    required DateTime dueDate,
    required bool completed,
    required String group,
    required UserResponse owner,
    required List<UserResponse> assignedTo,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? description,
  }) = _TaskResponse;

  const TaskResponse._();

  factory TaskResponse.fromJson(Map<String, dynamic> json) => _$TaskResponseFromJson(json);

  bool get isOverdue => !completed && dueDate.toLocal().isBefore(DateTime.now());

  String get formattedDueDate {
    final localDate = dueDate;
    final formatter = DateFormat('EEEE, d MMMM - hh:mm a');

    return formatter.format(localDate.toLocal());
  }

  String get formattedCreatedAt {
    final localDate = createdAt;
    final formatter = DateFormat('EEEE, d MMMM - hh:mm a');

    return formatter.format(localDate.toLocal());
  }

  String get formattedUpdatedAt {
    final localDate = updatedAt;
    final formatter = DateFormat('EEEE, d MMMM - hh:mm a');

    return formatter.format(localDate.toLocal());
  }
}
