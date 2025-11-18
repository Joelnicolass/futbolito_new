import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';

class RegisterFcmTokenUseCase {
  final AuthRepository repository;

  RegisterFcmTokenUseCase(this.repository);

  Future<void> call({required String userId, required String token}) async {
    return await repository.registerFcmToken(userId: userId, token: token);
  }
}
