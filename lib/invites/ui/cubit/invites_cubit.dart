import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/invites/invites.dart';

part 'invites_cubit.freezed.dart';

class InvitesCubit extends Cubit<InvitesState> {
  InvitesCubit({required this.invitesRepository}) : super(const InvitesState(isLoading: false, invites: []));

  static final _log = Logger('InvitesCubit');

  @visibleForTesting
  final InvitesRepository invitesRepository;

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
      await invitesRepository.accept(inviteId: invite.id, groupId: invite.group.id);
      emit(
        state.copyWith(invites: state.invites.map((item) => item.id == invite.id ? invite.copyWith(status: InviteStatus.accepted) : item).toList()),
      );
    } catch (e) {
      _log.severe('Error accepting invite: $e', e);
    }
  }

  Future<void> rejectInvite(InviteResponse invite) async {
    try {
      await invitesRepository.reject(inviteId: invite.id, groupId: invite.group.id);
      emit(state.copyWith(invites: state.invites.where((item) => item.id != invite.id).toList()));
    } catch (e) {
      _log.severe('Error rejecting invite: $e', e);
    }
  }
}

@freezed
sealed class InvitesState with _$InvitesState {
  const factory InvitesState({required bool isLoading, required List<InviteResponse> invites}) = _InvitesState;
}
