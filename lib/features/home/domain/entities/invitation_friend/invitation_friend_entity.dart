import 'package:freezed_annotation/freezed_annotation.dart';

part 'invitation_friend_entity.freezed.dart';

@freezed
abstract class InvitationFriendEntity with _$InvitationFriendEntity {
  const factory InvitationFriendEntity({
    required String id,
    required String email,
    required String displayName,
    String? photoUrl,
  }) = _InvitationsEntity;
}
