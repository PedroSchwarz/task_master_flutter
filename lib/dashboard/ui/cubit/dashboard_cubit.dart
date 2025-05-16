import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/users/data/repository/users_repository.dart';

part 'dashboard_cubit.freezed.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required this.authRepository,
    required this.usersRepository,
    required this.groupsRepository,
    required this.invitesRepository,
    required this.groupsWebsocket,
  }) : super(const DashboardState(isLoading: false, groups: [], invites: []));

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
  final GroupsWebsocket groupsWebsocket;

  UserData get currentUser => authRepository.currentUser.value!;

  StreamSubscription<String>? _groupsSubscription;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));

    _groupsSubscription = groupsWebsocket.groupsUpdatedStream.listen((id) {
      if (state.groups.any((group) => group.id == id)) {
        loadGroups();
      }
    });

    await Future.wait([loadGroups(), loadInvites(), usersRepository.updateDeviceToken()]);

    emit(state.copyWith(isLoading: false));
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
    try {
      final invites = await invitesRepository.getInvites(status: InviteStatus.pending.name);
      emit(state.copyWith(invites: invites));
    } catch (e) {
      _log.info('Error loading invites: $e', e);
    }
  }

  void updateGroupsForUsers({required String groupId}) {
    groupsWebsocket.updateGroups(groupId: groupId);
  }

  void signOut() async {
    await _groupsSubscription?.cancel();
    await usersRepository.removeNotifications();
    await authRepository.signOut();
  }
}

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState({required bool isLoading, required List<GroupResponse> groups, required List<InviteResponse> invites}) =
      _DashboardState;
}
