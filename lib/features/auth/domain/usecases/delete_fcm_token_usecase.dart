import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';

class DeleteFcmTokenUseCase {
  final AuthRepository repository;

  DeleteFcmTokenUseCase(this.repository);

  Future<void> call(String token) async {
    return await repository.deleteFcmToken(token);
  }
}
