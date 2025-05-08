import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/groups/data/repository/groups_repository.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/users/data/models/user_response.dart';
import 'package:task_master/users/data/repository/users_repository.dart';

part 'create_group_cubit.freezed.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit({required this.groupsRepository, required this.invitesRepository, required this.usersRepository})
    : super(
        const CreateGroupState(
          users: [],
          selectedUsersIds: [],
          name: '',
          description: '',
          showInviteUsersSheet: false,
          isLoading: false,
          shouldGoBack: false,
        ),
      );

  static final _log = Logger('CreateGroupCubit');

  @visibleForTesting
  final GroupsRepository groupsRepository;

  @visibleForTesting
  final InvitesRepository invitesRepository;

  @visibleForTesting
  final UsersRepository usersRepository;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));

    try {
      final users = await usersRepository.getUsers();
      emit(state.copyWith(users: users));
    } catch (e) {
      _log.severe('Error loading users: $e', e);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void toggleInviteUsersSheet() {
    emit(state.copyWith(showInviteUsersSheet: !state.showInviteUsersSheet));
  }

  void updateSelectedUsersIds(List<String> selectedUsersIds) {
    emit(state.copyWith(selectedUsersIds: selectedUsersIds));
  }

  Future<void> createGroup() async {
    emit(state.copyWith(isLoading: true));
    try {
      final groupId = await groupsRepository.createGroup(name: state.name, description: state.description);

      await Future.wait([for (final id in state.selectedUsersIds) invitesRepository.create(groupId: groupId, userId: id)]);

      emit(state.copyWith(shouldGoBack: true));
    } catch (e) {
      _log.severe('Error creating group: $e', e);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}

@freezed
sealed class CreateGroupState with _$CreateGroupState {
  const factory CreateGroupState({
    required List<UserResponse> users,
    required List<String> selectedUsersIds,
    required String name,
    required String description,
    required bool showInviteUsersSheet,
    required bool isLoading,
    required bool shouldGoBack,
  }) = _CreateGroupState;

  const CreateGroupState._();

  bool get isFormValid => name.isNotEmpty;

  bool get isButtonEnabled => isFormValid && !isLoading;
}
