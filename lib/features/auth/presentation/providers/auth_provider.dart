import 'package:futbolitonew/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/features/auth/domain/entities/user.dart';
import 'package:futbolitonew/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_in_with_apple_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_out_usecase.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<User?> build() async {
    final useCase = getIt<GetCurrentUserUseCase>();
    return await useCase();
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCaseSignIn = getIt<SignInWithGoogleUseCase>();
      final useCaseRegisterUser = getIt<RegisterUserUseCase>();
      final user = await useCaseSignIn();

      await useCaseRegisterUser(
        firebaseUid: user.id,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoUrl,
      );

      return user;
    });
  }

  Future<void> signInWithApple() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCaseSignIn = getIt<SignInWithAppleUseCase>();
      final useCaseRegisterUser = getIt<RegisterUserUseCase>();
      final user = await useCaseSignIn();

      await useCaseRegisterUser(
        firebaseUid: user.id,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoUrl,
      );

      return user;
    });
  }

  Future<void> signOut() async {
    final useCase = getIt<SignOutUseCase>();
    await useCase();
  }
}
