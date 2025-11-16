import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';

/// Caso de uso para cerrar sesión
/// Encapsula la lógica de negocio para cerrar sesión del usuario
class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() async {
    await repository.signOut();
  }
}
