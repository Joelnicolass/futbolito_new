import 'package:futbolitonew/features/home/data/datasources/remote/remote_datasource.dart';
import 'package:futbolitonew/features/home/data/models/invitation_friend/invitation_friend_model.dart';
import 'package:futbolitonew/features/home/domain/entities/invitation_friend/invitation_friend_entity.dart';
import 'package:futbolitonew/features/home/domain/repositories/invitation_friend/invitation_friend_repository.dart';

class InvitationFriendRepositoryImpl implements InvitationFriendRepository {
  final InvitaitonFriendDatasource datasoruce;

  InvitationFriendRepositoryImpl(this.datasoruce);

  @override
  Future<void> acceptInvitation(String invitationId) {
    // TODO: implement acceptInvitation
    throw UnimplementedError();
  }

  @override
  Future<void> declineInvitation(String invitationId) {
    // TODO: implement declineInvitation
    throw UnimplementedError();
  }

  @override
  Future<List<InvitationFriendEntity>> getPendingInvitations({
    required String userId,
    required String email,
  }) async {
    try {
      final results = await datasoruce.fetchPendingFriendRequests(
        userId: userId,
        email: email,
      );

      return InvitationFriendModel.fromJsonList(
        results,
      ).map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception(
        'Error al obtener las invitaciones pendientes: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> sendInvitation(String email) {
    // TODO: implement sendInvitation
    throw UnimplementedError();
  }
}
