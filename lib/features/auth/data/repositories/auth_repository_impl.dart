import 'package:futbolitonew/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:futbolitonew/features/auth/data/models/user_model.dart';
import 'package:futbolitonew/features/auth/domain/entities/user.dart';
import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';

/// Implementación del repositorio de autenticación
/// Conecta la capa de dominio con la capa de datos
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
}
