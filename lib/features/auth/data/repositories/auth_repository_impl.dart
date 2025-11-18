import 'package:futbolitonew/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:futbolitonew/features/auth/data/models/user_model.dart';
import 'package:futbolitonew/features/auth/domain/entities/user.dart';
import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<User> signInWithGoogle() async {
    try {
      final userCredential = await dataSource.signInWithGoogle();
      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception('No se pudo obtener la información del usuario');
      }

      return UserModel.fromFirebaseUser(
        firebaseUser.uid,
        firebaseUser.email ?? '',
        displayName: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
      ).toEntity();
    } catch (e) {
      throw Exception('Error al iniciar sesión con Google: ${e.toString()}');
    }
  }

  @override
  Future<User> signInWithApple() async {
    try {
      final userCredential = await dataSource.signInWithApple();
      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception('No se pudo obtener la información del usuario');
      }

      return UserModel.fromFirebaseUser(
        firebaseUser.uid,
        firebaseUser.email ?? '',
        displayName: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
      ).toEntity();
    } catch (e) {
      throw Exception('Error al iniciar sesión con Apple: ${e.toString()}');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final firebaseUser = dataSource.getCurrentFirebaseUser();

    if (firebaseUser == null) {
      return null;
    }

    return UserModel.fromFirebaseUser(
      firebaseUser.uid,
      firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
    ).toEntity();
  }

  @override
  Future<void> signOut() async {
    try {
      await dataSource.signOut();
    } catch (e) {
      throw Exception('Error al cerrar sesión: ${e.toString()}');
    }
  }

  @override
  Future<User> registerUser({
    required String firebaseUid,
    required String email,
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      final supabaseUser = await dataSource.registerUserInSupabase(
        firebaseUid: firebaseUid,
        email: email,
        displayName: displayName,
        photoUrl: photoUrl,
      );

      return UserModel(
        id: supabaseUser['id'].toString(),
        email: supabaseUser['email'] as String,
        displayName: supabaseUser['display_name'] as String?,
        photoUrl: supabaseUser['photo_url'] as String?,
      ).toEntity();
    } catch (e) {
      throw Exception('Error al registrar usuario: ${e.toString()}');
    }
  }

  @override
  Future<User?> getUserFromSupabase(String firebaseUid) async {
    try {
      final supabaseUser = await dataSource.getUserFromSupabase(firebaseUid);

      if (supabaseUser == null) {
        return null;
      }

      return UserModel(
        id: supabaseUser['id'].toString(),
        email: supabaseUser['email'] as String,
        displayName: supabaseUser['display_name'] as String?,
        photoUrl: supabaseUser['photo_url'] as String?,
      ).toEntity();
    } catch (e) {
      throw Exception('Error al obtener usuario de Supabase: ${e.toString()}');
    }
  }

  @override
  Future<void> registerFcmToken({
    required String userId,
    required String token,
  }) async {
    try {
      await dataSource.registerFcmToken(userId: userId, token: token);
    } catch (e) {
      throw Exception('Error al registrar FCM token: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteFcmToken(String token) async {
    try {
      await dataSource.deleteFcmToken(token);
    } catch (e) {
      throw Exception('Error al eliminar FCM token: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteUserFcmTokens(String userId) async {
    try {
      await dataSource.deleteUserFcmTokens(userId);
    } catch (e) {
      throw Exception('Error al eliminar tokens del usuario: ${e.toString()}');
    }
  }
}
