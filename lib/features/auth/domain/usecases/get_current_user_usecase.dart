import 'package:futbolitonew/features/auth/domain/entities/user.dart';
import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';

/// Caso de uso para obtener el usuario actual autenticado
/// Encapsula la lógica de negocio para obtener el usuario actual
class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<User?> call() async {
    return await repository.getCurrentUser();
  }
}
