import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/invites/invites.dart';

part 'invites_cubit.freezed.dart';

class InvitesCubit extends Cubit<InvitesState> {
  InvitesCubit({required this.invitesRepository, required this.groupsRepository, required this.groupsWebsocket})
    : super(const InvitesState(isLoading: false, invites: []));

  static final _log = Logger('InvitesCubit');

  @visibleForTesting
  final InvitesRepository invitesRepository;

  @visibleForTesting
  final GroupsRepository groupsRepository;

  @visibleForTesting
  final GroupsWebsocket groupsWebsocket;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));
    try {
      final invites = await invitesRepository.getInvites(status: InviteStatus.pending.name);
      emit(state.copyWith(invites: invites));
    } catch (e) {
      _log.severe('Error loading invites: $e', e);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> acceptInvite(InviteResponse invite) async {
    try {
      await invitesRepository.accept(invite.id);
      await groupsRepository.addMemberToGroup(invite.group.id);
      groupsWebsocket.updateGroups(groupId: invite.group.id);
    } catch (e) {
      _log.severe('Error accepting invite: $e', e);
    } finally {
      emit(
        state.copyWith(invites: state.invites.map((item) => item.id == invite.id ? invite.copyWith(status: InviteStatus.accepted) : item).toList()),
      );
    }
  }

  Future<void> rejectInvite(InviteResponse invite) async {
    try {
      await invitesRepository.reject(invite.id);
    } catch (e) {
      _log.severe('Error rejecting invite: $e', e);
    } finally {
      emit(state.copyWith(invites: state.invites.where((item) => item.id != invite.id).toList()));
    }
  }
}

@freezed
sealed class InvitesState with _$InvitesState {
  const factory InvitesState({required bool isLoading, required List<InviteResponse> invites}) = _InvitesState;
}
