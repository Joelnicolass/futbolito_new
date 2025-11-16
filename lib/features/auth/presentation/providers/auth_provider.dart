import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/features/auth/domain/entities/user.dart';
import 'package:futbolitonew/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_out_usecase.dart';

part 'auth_provider.g.dart';

/// Provider del estado de autenticación
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<User?> build() async {
    // Cargar usuario actual al inicializar
    final useCase = getIt<GetCurrentUserUseCase>();
    return await useCase();
  }

  /// Inicia sesión con Google
  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = getIt<SignInWithGoogleUseCase>();
      return await useCase();
    });
  }

  /// Cierra sesión
  Future<void> signOut() async {
    final useCase = getIt<SignOutUseCase>();
    await useCase();
    // El stream de authStateChanges actualizará el estado automáticamente
  }
}
