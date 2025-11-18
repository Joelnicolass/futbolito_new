import 'package:futbolitonew/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> signInWithGoogle();
  Future<User> signInWithApple();
  Future<User?> getCurrentUser();
  Future<void> signOut();

  /// Registra un nuevo usuario en Supabase después de la autenticación con Firebase
  Future<User> registerUser({
    required String firebaseUid,
    required String email,
    String? displayName,
    String? photoUrl,
  });

  /// Obtiene un usuario de Supabase por su firebase_uid
  Future<User?> getUserFromSupabase(String firebaseUid);

  /// Registra o actualiza el FCM token del usuario en Supabase
  Future<void> registerFcmToken({
    required String userId,
    required String token,
  });

  /// Elimina un FCM token específico
  Future<void> deleteFcmToken(String token);

  /// Elimina todos los FCM tokens de un usuario
  Future<void> deleteUserFcmTokens(String userId);
}
