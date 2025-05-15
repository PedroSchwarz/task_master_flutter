import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/users/data/repository/users_repository.dart';

part 'dashboard_cubit.freezed.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required this.authRepository, required this.usersRepository, required this.groupsRepository, required this.invitesRepository})
    : super(const DashboardState(isLoading: false, groups: [], invites: []));

  static final _log = Logger('DashboardCubit');

  @visibleForTesting
  final AuthRepository authRepository;

  @visibleForTesting
  final UsersRepository usersRepository;

  @visibleForTesting
  final GroupsRepository groupsRepository;

  @visibleForTesting
  final InvitesRepository invitesRepository;

  UserData get currentUser => authRepository.currentUser.value!;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));

    try {
      final groups = await groupsRepository.getGroups();
      emit(state.copyWith(groups: groups..sort((a, b) => b.createdAt.compareTo(a.createdAt)), invites: []));
      final invites = await invitesRepository.getInvites(status: InviteStatus.pending.name);
      emit(state.copyWith(invites: invites));
      await usersRepository.updateDeviceToken();
    } catch (e) {
      _log.info('Error loading dashboard: $e', e);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void signOut() async {
    await usersRepository.removeNotifications();
    await authRepository.signOut();
  }
}

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState({required bool isLoading, required List<GroupResponse> groups, required List<InviteResponse> invites}) =
      _DashboardState;
}
