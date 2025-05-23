import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/auth/auth.dart';
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
    required this.groupsRepository,
    required this.invitesRepository,
    required this.getTasksProgressionForWeeksUseCase,
    required this.groupsWebsocket,
    required this.tasksWebsocket,
  }) : super(const DashboardState(isLoading: false, groups: [], invites: [], progression: [], isRefreshing: false));

  static final _log = Logger('DashboardCubit');

  @visibleForTesting
  final AuthRepository authRepository;

  @visibleForTesting
  final UsersRepository usersRepository;

  @visibleForTesting
  final GroupsRepository groupsRepository;

  @visibleForTesting
  final InvitesRepository invitesRepository;

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
        loadProgressions();
      }
    });

    await Future.wait([loadGroups(), loadInvites(), loadProgressions(), usersRepository.updateDeviceToken()]);

    emit(state.copyWith(isLoading: false));
  }

  Future<void> refresh() async {
    emit(state.copyWith(isRefreshing: true));
    await Future.wait([loadGroups(), loadInvites(), loadProgressions()]);
    emit(state.copyWith(isRefreshing: false));
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

    _invitesFetchTimer = Timer.periodic(const Duration(minutes: 2), (_) async {
      try {
        final invites = await invitesRepository.getInvites(status: InviteStatus.pending.name);
        emit(state.copyWith(invites: invites));
      } catch (e) {
        _log.info('Error loading invites: $e', e);
      }
    });
  }

  Future<void> loadProgressions() async {
    try {
      final progression = await getTasksProgressionForWeeksUseCase();
      emit(state.copyWith(progression: progression));
    } catch (e) {
      _log.info('Error loading progressions: $e', e);
    }
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
    required List<GroupResponse> groups,
    required List<InviteResponse> invites,
    required List<WeeklyTaskProgression?> progression,
    required bool isRefreshing,
  }) = _DashboardState;
}
