import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/dashboard/dashboard.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/progress/progress.dart';
import 'package:task_master/tasks/tasks.dart';
import 'package:task_master/users/data/repository/users_repository.dart';

part 'dashboard_cubit.freezed.dart';
part 'dashboard_cubit.g.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required this.authRepository,
    required this.usersRepository,
    required this.dashboardRepository,
    required this.groupsRepository,
    required this.tasksRepository,
    required this.invitesRepository,
    required this.progressRepository,
    required this.getTasksProgressionForWeeksUseCase,
    required this.groupsWebsocket,
    required this.tasksWebsocket,
  }) : super(
         const DashboardState(
           isLoading: false,
           showingProgression: false,
           showingHighlights: false,
           groupsListType: .list,
           groups: [],
           upcomingTasks: [],
           overdueTasks: [],
           invites: [],
           progression: [],
           selection: .owned,
           showGroupSearch: false,
           groupSearchQuery: '',
           isRefreshing: false,
         ),
       );

  static final _log = Logger('DashboardCubit');

  @visibleForTesting
  final AuthRepository authRepository;

  @visibleForTesting
  final UsersRepository usersRepository;

  @visibleForTesting
  final DashboardRepository dashboardRepository;

  @visibleForTesting
  final GroupsRepository groupsRepository;

  @visibleForTesting
  final TasksRepository tasksRepository;

  @visibleForTesting
  final InvitesRepository invitesRepository;

  @visibleForTesting
  final ProgressRepository progressRepository;

  @visibleForTesting
  final GetTasksProgressionForWeeksUseCase getTasksProgressionForWeeksUseCase;

  @visibleForTesting
  final GroupsWebsocket groupsWebsocket;

  @visibleForTesting
  final TasksWebsocket tasksWebsocket;

  UserData get currentUser => authRepository.currentUser.value!;

  StreamSubscription<String>? _groupsSubscription;

  StreamSubscription<String>? _tasksSubscription;

  Timer? _invitesFetchTimer;

  Future<void> load() async {
    final hasContent = state.groups.isNotEmpty;

    emit(state.copyWith(isLoading: !hasContent, isRefreshing: hasContent));

    _groupsSubscription = groupsWebsocket.groupsUpdatedStream.listen((id) {
      if (state.groups.any((group) => group.id == id)) {
        refresh();
      }
    });

    _tasksSubscription = tasksWebsocket.tasksUpdatedStream.listen((id) async {
      final progressionIds = state.progression.nonNulls.expand(
        (progression) => progression.taskIds,
      );
      final isInProgression = progressionIds.any((taskId) => taskId == id);
      final upcomingIds = state.upcomingTasks.map((task) => task.id);
      final isInUpcoming = upcomingIds.any((taskId) => taskId == id);
      final overdueIds = state.overdueTasks.map((task) => task.id);
      final isInOverdue = overdueIds.any((taskId) => taskId == id);

      await Future.wait([
        if (isInProgression) loadProgression(selection: state.selection),
        if (isInUpcoming) loadUpcomingTasks(),
        if (isInOverdue) loadOverdueTasks(),
      ]);
    });

    final selection = await progressRepository.getProgressionSelection();
    emit(state.copyWith(selection: selection));

    await Future.wait([
      loadProgressionAndHighlight(),
      loadGroupsListType(),
      loadGroups(),
      loadInvites(),
      loadUpcomingTasks(),
      loadOverdueTasks(),
      loadProgression(selection: selection),
      usersRepository.updateDeviceToken(),
    ]);

    emit(state.copyWith(isLoading: false, isRefreshing: false));
  }

  Future<void> refresh() async {
    emit(state.copyWith(isRefreshing: true));
    await Future.wait([
      loadGroups(),
      loadInvites(),
      loadUpcomingTasks(),
      loadOverdueTasks(),
      loadProgression(selection: state.selection),
    ]);
    emit(state.copyWith(isRefreshing: false));
  }

  Future<void> loadProgressionAndHighlight() async {
    final result = await Future.wait([
      dashboardRepository.getShowingProgression(),
      dashboardRepository.getShowingHighlights(),
    ]);
    emit(
      state.copyWith(
        showingProgression: result.first,
        showingHighlights: result.last,
      ),
    );
  }

  Future<void> loadGroupsListType() async {
    final type = await dashboardRepository.getGroupsListType();
    emit(state.copyWith(groupsListType: type));
  }

  Future<void> loadGroups() async {
    try {
      final groups = await groupsRepository.getGroups();
      emit(
        state.copyWith(
          groups: groups..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
          invites: [],
        ),
      );
    } catch (e) {
      _log.info('Error loading groups: $e', e);
    }
  }

  Future<void> loadInvites() async {
    _invitesFetchTimer?.cancel();

    try {
      final List<InviteResponse> invites = await invitesRepository.getInvites(
        status: InviteStatus.pending.name,
      );
      emit(state.copyWith(invites: invites));
      _invitesFetchTimer = Timer(const Duration(minutes: 2), loadInvites);
    } catch (e) {
      _log.info('Error loading invites: $e', e);
    }
  }

  Future<void> loadUpcomingTasks() async {
    try {
      final tasks = await tasksRepository.getUpcoming();
      emit(state.copyWith(upcomingTasks: tasks));
    } catch (e) {
      _log.info('Error loading upcoming tasks: $e', e);
    }
  }

  Future<void> loadOverdueTasks() async {
    try {
      final tasks = await tasksRepository.getOverdue();
      emit(state.copyWith(overdueTasks: tasks));
    } catch (e) {
      _log.info('Error loading overdue tasks: $e', e);
    }
  }

  Future<void> loadProgression({
    required TaskProgressionSelection selection,
  }) async {
    try {
      final progression = await getTasksProgressionForWeeksUseCase(
        selection: selection,
      );
      emit(state.copyWith(progression: progression));
    } catch (e) {
      _log.info('Error loading progressions: $e', e);
    }
  }

  Future<void> updateGroupsListType() async {
    final GroupsListType type = state.groupsListType == .list ? .grid : .list;
    emit(state.copyWith(groupsListType: type));
    await dashboardRepository.setGroupsListType(type);
  }

  Future<void> updateShowingProgression({required bool value}) async {
    await dashboardRepository.setShowingProgression(value);
    emit(state.copyWith(showingProgression: value));
  }

  Future<void> updateShowingHighlight({required bool value}) async {
    await dashboardRepository.setShowingHighlights(value);
    emit(state.copyWith(showingHighlights: value));
  }

  Future<void> updateSelection(TaskProgressionSelection selection) async {
    emit(state.copyWith(isRefreshing: true, selection: selection));
    await Future.wait([
      loadProgression(selection: selection),
      progressRepository.setProgressionSelection(selection),
    ]);
    emit(state.copyWith(isRefreshing: false));
  }

  void updateGroupsForUsers({required String groupId}) {
    groupsWebsocket.updateGroups(groupId: groupId);
  }

  void updateShowGroupSearch({required bool value}) {
    emit(
      state.copyWith(
        showGroupSearch: value,
        groupSearchQuery: !value ? '' : state.groupSearchQuery,
      ),
    );
  }

  void updateGroupSearchQuery(String value) {
    emit(state.copyWith(groupSearchQuery: value));
  }

  void signOut() async {
    _invitesFetchTimer?.cancel();
    _invitesFetchTimer = null;
    await _groupsSubscription?.cancel();
    await _tasksSubscription?.cancel();
    await usersRepository.removeNotifications();
    await authRepository.signOut();
  }
}

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState({
    required bool isLoading,
    required bool showingProgression,
    required bool showingHighlights,
    required GroupsListType groupsListType,
    required List<GroupResponse> groups,
    required List<TaskResponse> upcomingTasks,
    required List<TaskResponse> overdueTasks,
    required List<InviteResponse> invites,
    required List<WeeklyTaskProgression?> progression,
    required TaskProgressionSelection selection,
    required bool showGroupSearch,
    required String groupSearchQuery,
    required bool isRefreshing,
  }) = _DashboardState;

  const DashboardState._();

  factory DashboardState.fromJson(Map<String, dynamic> json) =>
      _$DashboardStateFromJson(json);

  List<GroupResponse> get filteredGroups => groupSearchQuery.isEmpty
      ? groups
      : groups.where(
          (group) {
            return group.name.toLowerCase().contains(
                  groupSearchQuery.toLowerCase(),
                ) ||
                group.description.toLowerCase().contains(
                  groupSearchQuery.toLowerCase(),
                );
          },
        ).toList();
}
