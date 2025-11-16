import 'package:futbolitonew/features/auth/domain/entities/user.dart';
import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';

/// Caso de uso para iniciar sesión con Apple
/// Encapsula la lógica de negocio para autenticación con Apple
class SignInWithAppleUseCase {
  final AuthRepository repository;

  SignInWithAppleUseCase(this.repository);

  Future<User> call() async {
    return await repository.signInWithApple();
  }
}
