import 'package:flutter/foundation.dart';
import 'package:task_master/invites/data/data_sources/invites_remote_data_source.dart';
import 'package:task_master/invites/data/models/create_invite_request.dart';
import 'package:task_master/invites/data/models/invite_response.dart';

class InvitesRepository {
  const InvitesRepository({required this.invitesRemoteDataSource});

  @visibleForTesting
  final InvitesRemoteDataSource invitesRemoteDataSource;

  Future<List<InviteResponse>> getInvites() async {
    return await invitesRemoteDataSource.fetchAll();
  }

  Future<void> create({required String userId, required String groupId}) async {
    return await invitesRemoteDataSource.create(
      CreateInviteRequest(to: userId, groupId: groupId),
    );
  }
}
