import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSource({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    SupabaseClient? supabaseClient,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn(scopes: ['email']),
       _supabaseClient = supabaseClient ?? Supabase.instance.client;

  Future<firebase_auth.UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception('El usuario canceló el inicio de sesión');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<firebase_auth.UserCredential> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = firebase_auth.OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    return await _firebaseAuth.signInWithCredential(oauthCredential);
  }

  firebase_auth.User? getCurrentFirebaseUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  Stream<firebase_auth.User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  Future<Map<String, dynamic>> registerUserInSupabase({
    required String firebaseUid,
    required String email,
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      final existingUser = await _supabaseClient
          .from('users')
          .select()
          .eq('firebase_uid', firebaseUid)
          .maybeSingle();

      if (existingUser != null) return existingUser;

      final response = await _supabaseClient
          .from('users')
          .insert({
            'firebase_uid': firebaseUid,
            'email': email,
            'display_name': displayName,
            'photo_url': photoUrl,
            'created_at': DateTime.now().toUtc().toIso8601String(),
            'updated_at': DateTime.now().toUtc().toIso8601String(),
          })
          .select()
          .single();

      return response;
    } catch (e) {
      throw Exception(
        'Error al registrar usuario en Supabase: ${e.toString()}',
      );
    }
  }

  Future<Map<String, dynamic>?> getUserFromSupabase(String firebaseUid) async {
    try {
      final response = await _supabaseClient
          .from('users')
          .select()
          .eq('firebase_uid', firebaseUid)
          .maybeSingle();

      return response;
    } catch (e) {
      throw Exception('Error al obtener usuario de Supabase: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> registerFcmToken({
    required String userId,
    required String token,
  }) async {
    try {
      final existingToken = await _supabaseClient
          .from('fcm_tokens')
          .select()
          .eq('token', token)
          .maybeSingle();

      if (existingToken != null) return existingToken;

      final response = await _supabaseClient
          .from('fcm_tokens')
          .insert({
            'user_id': userId,
            'token': token,
            'created_at': DateTime.now().toUtc().toIso8601String(),
            'updated_at': DateTime.now().toUtc().toIso8601String(),
          })
          .select()
          .single();

      return response;
    } catch (e) {
      throw Exception('Error al registrar FCM token: ${e.toString()}');
    }
  }

  Future<void> deleteFcmToken(String token) async {
    try {
      await _supabaseClient.from('fcm_tokens').delete().eq('token', token);
    } catch (e) {
      throw Exception('Error al eliminar FCM token: ${e.toString()}');
    }
  }

  Future<void> deleteUserFcmTokens(String userId) async {
    try {
      await _supabaseClient.from('fcm_tokens').delete().eq('user_id', userId);
    } catch (e) {
      throw Exception('Error al eliminar tokens del usuario: ${e.toString()}');
    }
  }
}
