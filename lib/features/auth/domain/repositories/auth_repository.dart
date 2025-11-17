import 'package:futbolitonew/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> signInWithGoogle();
  Future<User> signInWithApple();
  Future<User?> getCurrentUser();
  Future<void> signOut();
}
