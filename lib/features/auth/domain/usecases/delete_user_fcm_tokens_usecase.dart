import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';

class DeleteUserFcmTokensUseCase {
  final AuthRepository repository;

  DeleteUserFcmTokensUseCase(this.repository);

  Future<void> call(String userId) async {
    return await repository.deleteUserFcmTokens(userId);
  }
}
