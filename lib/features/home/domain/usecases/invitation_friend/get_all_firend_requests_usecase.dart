import 'package:futbolitonew/features/home/domain/entities/invitation_friend/invitation_friend_entity.dart';
import 'package:futbolitonew/features/home/domain/repositories/invitation_friend/invitation_friend_repository.dart';

class GetAllFirendRequestsUsecase {
  final InvitationFriendRepository repository;

  GetAllFirendRequestsUsecase(this.repository);

  Future<List<InvitationFriendEntity>> call({
    required String userId,
    required String email,
  }) async {
    return await repository.getPendingInvitations(userId: userId, email: email);
  }
}
