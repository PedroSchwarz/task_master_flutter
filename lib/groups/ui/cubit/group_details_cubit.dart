import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/invites/invites.dart';

part 'group_details_cubit.freezed.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  GroupDetailsCubit({required this.authRepository, required this.invitesRepository}) : super(const GroupDetailsState(isLoading: false, invites: []));

  @visibleForTesting
  final AuthRepository authRepository;

  @visibleForTesting
  final InvitesRepository invitesRepository;

  UserData get currentUser => authRepository.currentUser.value!;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));

    try {
      emit(state.copyWith(invites: []));
    } catch (e) {
      print(e);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void signOut() async {
    await authRepository.signOut();
  }
}

@freezed
sealed class GroupDetailsState with _$GroupDetailsState {
  const factory GroupDetailsState({required bool isLoading, required List<InviteResponse> invites}) = _GroupDetailsState;
}
