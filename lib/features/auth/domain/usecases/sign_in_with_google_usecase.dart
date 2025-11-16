import 'package:futbolitonew/features/auth/domain/entities/user.dart';
import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';

/// Caso de uso para iniciar sesión con Google
/// Encapsula la lógica de negocio para autenticación con Google
class SignInWithGoogleUseCase {
  final AuthRepository repository;

  SignInWithGoogleUseCase(this.repository);

  Future<User> call() async {
    return await repository.signInWithGoogle();
  }
}

