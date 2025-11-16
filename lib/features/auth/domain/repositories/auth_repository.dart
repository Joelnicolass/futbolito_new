import 'package:futbolitonew/features/auth/domain/entities/user.dart';

/// Interfaz del repositorio de autenticación
/// Define los contratos para operaciones de autenticación
abstract class AuthRepository {
  /// Inicia sesión con Google
  /// Retorna el usuario autenticado o lanza una excepción
  Future<User> signInWithGoogle();

  /// Inicia sesión con Apple
  /// Retorna el usuario autenticado o lanza una excepción
  Future<User> signInWithApple();

  /// Obtiene el usuario actual autenticado
  /// Retorna null si no hay usuario autenticado
  Future<User?> getCurrentUser();

  /// Cierra sesión del usuario actual
  Future<void> signOut();
}
