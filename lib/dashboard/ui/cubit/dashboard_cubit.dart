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

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required this.authRepository,
    required this.usersRepository,
    required this.dashboardRepository,
    required this.groupsRepository,
    required this.invitesRepository,
    required this.progressRepository,
    required this.getTasksProgressionForWeeksUseCase,
    required this.groupsWebsocket,
    required this.tasksWebsocket,
  }) : super(
         const DashboardState(
           isLoading: false,
           groupsListType: GroupsListType.list,
           groups: [],
           invites: [],
           progression: [],
           selection: TaskProgressionSelection.owned,
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
    emit(state.copyWith(isLoading: true));

    _groupsSubscription = groupsWebsocket.groupsUpdatedStream.listen((id) {
      if (state.groups.any((group) => group.id == id)) {
        refresh();
      }
    });

    _tasksSubscription = tasksWebsocket.tasksUpdatedStream.listen((id) {
      final ids = state.progression.nonNulls.expand((progression) => progression.taskIds);

      if (ids.any((taskId) => taskId == id)) {
        loadProgression();
      }
    });

    final selection = await progressRepository.getProgressionSelection();
    emit(state.copyWith(selection: selection));

    await Future.wait([loadGroupsListType(), loadGroups(), loadInvites(), loadProgression(), usersRepository.updateDeviceToken()]);

    emit(state.copyWith(isLoading: false));
  }

  Future<void> refresh() async {
    emit(state.copyWith(isRefreshing: true));
    await Future.wait([loadGroups(), loadInvites(), loadProgression()]);
    emit(state.copyWith(isRefreshing: false));
  }

  Future<void> loadGroupsListType() async {
    final type = await dashboardRepository.getGroupsListType();
    emit(state.copyWith(groupsListType: type));
  }

  Future<void> loadGroups() async {
    try {
      final groups = await groupsRepository.getGroups();
      emit(state.copyWith(groups: groups..sort((a, b) => b.createdAt.compareTo(a.createdAt)), invites: []));
    } catch (e) {
      _log.info('Error loading groups: $e', e);
    }
  }

  Future<void> loadInvites() async {
    _invitesFetchTimer?.cancel();

    try {
      final invites = await invitesRepository.getInvites(status: InviteStatus.pending.name);
      emit(state.copyWith(invites: invites));
      _invitesFetchTimer = Timer(const Duration(minutes: 2), loadInvites);
    } catch (e) {
      _log.info('Error loading invites: $e', e);
    }
  }

  Future<void> loadProgression() async {
    try {
      final progression = await getTasksProgressionForWeeksUseCase(selection: state.selection);
      emit(state.copyWith(progression: progression));
    } catch (e) {
      _log.info('Error loading progressions: $e', e);
    }
  }

  Future<void> updateGroupsListType() async {
    final type = state.groupsListType == GroupsListType.list ? GroupsListType.grid : GroupsListType.list;
    emit(state.copyWith(groupsListType: type));
    await dashboardRepository.setGroupsListType(type);
  }

  Future<void> updateSelection(TaskProgressionSelection selection) async {
    emit(state.copyWith(isRefreshing: true, selection: selection));
    await Future.wait([loadProgression(), progressRepository.setProgressionSelection(selection)]);
    emit(state.copyWith(isRefreshing: false));
  }

  void updateGroupsForUsers({required String groupId}) {
    groupsWebsocket.updateGroups(groupId: groupId);
  }

  void signOut() async {
    _invitesFetchTimer?.cancel();
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
    required GroupsListType groupsListType,
    required List<GroupResponse> groups,
    required List<InviteResponse> invites,
    required List<WeeklyTaskProgression?> progression,
    required TaskProgressionSelection selection,
    required bool isRefreshing,
  }) = _DashboardState;
}
