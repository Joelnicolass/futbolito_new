import 'package:supabase_flutter/supabase_flutter.dart';

abstract class InvitaitonFriendDatasource {
  Future<List<Map<String, dynamic>>> fetchPendingFriendRequests({
    required String userId,
    required String email,
  });
  Future<void> sendInvitation(String email);
  Future<void> acceptInvitation(String invitationId);
  Future<void> declineInvitation(String invitationId);
}

class InvitationsRemoteDataSource implements InvitaitonFriendDatasource {
  final SupabaseClient _supabaseClient;

  InvitationsRemoteDataSource({SupabaseClient? supabaseClient})
    : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchPendingFriendRequests({
    required String userId,
    required String email,
  }) async {
    try {
      final responseFriendships = await _supabaseClient
          .from('friendships')
          .select(
            'id, user_id, friend_id, status, created_at, users: user_id (id, display_name, email, photo_url)',
          )
          .eq('friend_id', userId)
          .eq('status', 'pending')
          .order('created_at', ascending: false);

      final responseInvitations = await _supabaseClient
          .from('invitations')
          .select(
            'id, sender_id, receiver_id, receiver_email, type, status, created_at, sender: sender_id (id, display_name, email, photo_url)',
          )
          .eq('type', 'friend')
          .eq('status', 'pending')
          .or('receiver_id.eq.${userId},receiver_email.ilike.*${email}*')
          .order('created_at', ascending: false);

      final combinedResults = [...responseFriendships, ...responseInvitations];

      return combinedResults;
    } catch (e) {
      throw Exception(
        'Error al obtener solicitudes de amistad: ${e.toString()}',
      );
    }
  }

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
  Future<void> sendInvitation(String email) {
    // TODO: implement sendInvitation
    throw UnimplementedError();
  }
}
