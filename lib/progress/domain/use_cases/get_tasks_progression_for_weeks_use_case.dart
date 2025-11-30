import 'package:flutter/foundation.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/progress/domain/models/task_progression_selection.dart';
import 'package:task_master/progress/domain/models/weekly_task_progression.dart';
import 'package:task_master/progress/domain/use_cases/get_users_current_week_use_case.dart';
import 'package:task_master/tasks/tasks.dart';

class GetTasksProgressionForWeeksUseCase {
  const GetTasksProgressionForWeeksUseCase({
    required this.authRepository,
    required this.tasksRepository,
    required this.getUsersCurrentWeekUseCase,
  });

  @visibleForTesting
  final AuthRepository authRepository;

  @visibleForTesting
  final TasksRepository tasksRepository;

  @visibleForTesting
  final GetUsersCurrentWeekUseCase getUsersCurrentWeekUseCase;

  Future<List<WeeklyTaskProgression?>> call({
    required TaskProgressionSelection selection,
    int weeks = 5,
  }) async {
    final assignedTasks = switch (selection) {
      .owned => await tasksRepository.getAllOwned(),
      .assigned => await tasksRepository.getAllAssigned(),
    };

    final registrationDate = authRepository.currentUser.value!.createdAt
        .toLocal();

    final currentWeek = getUsersCurrentWeekUseCase();

    final actualWeeks = currentWeek < weeks ? currentWeek : weeks;

    List<WeeklyTaskProgression?> progressions = [];

    for (int i = 0; i < weeks - actualWeeks; i++) {
      progressions.add(null);
    }

    for (int i = 0; i < actualWeeks; i++) {
      final weekNumber = currentWeek - i;

      final startOfWeek = registrationDate.add(
        Duration(days: (weekNumber - 1) * 7),
      );
      final endOfWeek = startOfWeek.add(
        const Duration(days: 6, hours: 23, minutes: 59, seconds: 59),
      );

      final tasksInThisWeek = assignedTasks.where((task) {
        final taskDate = task.dueDate.toLocal();
        return taskDate.isAfter(
              startOfWeek.subtract(const Duration(seconds: 1)),
            ) &&
            taskDate.isBefore(endOfWeek.add(const Duration(seconds: 1)));
      }).toList();

      final completedTasks = tasksInThisWeek.where((task) => task.completed);

      final overdueTasks = tasksInThisWeek.where(
        (task) =>
            !task.completed && task.dueDate.toLocal().isBefore(DateTime.now()),
      );

      progressions.add(
        WeeklyTaskProgression(
          week: weekNumber,
          startDate: startOfWeek,
          endDate: endOfWeek,
          completed: completedTasks.length,
          total: tasksInThisWeek.length,
          overdue: overdueTasks.length,
          tasks: tasksInThisWeek,
        ),
      );
    }

    return progressions.reversed.toList();
  }
}
