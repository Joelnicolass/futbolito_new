import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:futbolitonew/features/home/domain/entities/invitation_friend/invitation_friend_entity.dart';

part 'invitation_friend_model.freezed.dart';

@freezed
abstract class InvitationFriendModel with _$InvitationFriendModel {
  const InvitationFriendModel._();

  const factory InvitationFriendModel({
    required String id,
    required String email,
    required String displayName,
    String? photoUrl,
  }) = _InvitationFriendModel;

  static InvitationFriendModel fromResponseJson(Map<String, dynamic> json) {
    return InvitationFriendModel(
      id: json['id'] as String,
      email: json['sender']['email'] as String,
      displayName: json['sender']['display_name'] as String,
      photoUrl: json['sender']['photo_url'] as String?,
    );
  }

  InvitationFriendEntity toEntity() {
    return InvitationFriendEntity(
      id: id,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

  static List<InvitationFriendModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => InvitationFriendModel.fromResponseJson(json))
        .toList();
  }
}
