import 'package:futbolitonew/features/home/domain/entities/invitation_friend/invitation_friend_entity.dart';

abstract class InvitationFriendRepository {
  Future<void> sendInvitation(String email);
  Future<List<InvitationFriendEntity>> getPendingInvitations({
    required String userId,
    required String email,
  });
  Future<void> acceptInvitation(String invitationId);
  Future<void> declineInvitation(String invitationId);
}
