import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:futbolitonew/features/home/domain/entities/invitation_friend/invitation_friend_entity.dart';

part 'invitations_state.freezed.dart';

@freezed
abstract class InvitationsState with _$InvitationsState {
  const factory InvitationsState({
    @Default([]) List<InvitationFriendEntity> pendingRequests,
  }) = _InvitationsState;
}
