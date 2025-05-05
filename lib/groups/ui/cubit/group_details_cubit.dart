import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/tasks/tasks.dart';

part 'group_details_cubit.freezed.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  GroupDetailsCubit({required this.authRepository, required this.groupsRepository, required this.tasksRepository, required this.invitesRepository})
    : super(const GroupDetailsState(isLoading: false, tasks: [], invites: []));

  @visibleForTesting
  final AuthRepository authRepository;

  @visibleForTesting
  final GroupsRepository groupsRepository;

  @visibleForTesting
  final TasksRepository tasksRepository;

  @visibleForTesting
  final InvitesRepository invitesRepository;

  UserData get currentUser => authRepository.currentUser.value!;

  Future<void> load({required String groupId}) async {
    emit(state.copyWith(isLoading: true));

    try {
      await Future.wait([loadGroup(groupId: groupId), loadTasks(groupId: groupId)]);
      emit(state.copyWith(invites: []));
    } catch (e) {
      print(e);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> loadGroup({required String groupId}) async {
    try {
      final group = await groupsRepository.getGroupById(groupId);
      emit(state.copyWith(group: group));
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadTasks({required String groupId}) async {
    try {
      final tasks = await tasksRepository.fetchAll(groupId);
      emit(state.copyWith(tasks: tasks));
    } catch (e) {
      print(e);
    }
  }

  void signOut() async {
    await authRepository.signOut();
  }
}

@freezed
sealed class GroupDetailsState with _$GroupDetailsState {
  const factory GroupDetailsState({
    required bool isLoading,
    required List<TaskResponse> tasks,
    required List<InviteResponse> invites,
    GroupResponse? group,
  }) = _GroupDetailsState;
}
