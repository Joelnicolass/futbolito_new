import 'package:futbolitonew/features/auth/domain/entities/user.dart';
import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';

class GetUserFromSupabaseUseCase {
  final AuthRepository repository;

  GetUserFromSupabaseUseCase(this.repository);

  Future<User?> call(String firebaseUid) async {
    return await repository.getUserFromSupabase(firebaseUid);
  }
}
