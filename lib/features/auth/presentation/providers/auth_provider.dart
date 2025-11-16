import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/features/auth/domain/entities/user.dart';
import 'package:futbolitonew/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_out_usecase.dart';

part 'auth_provider.g.dart';

/// Provider del caso de uso de inicio de sesión con Google
@riverpod
SignInWithGoogleUseCase signInWithGoogleUseCase(Ref ref) {
  return getIt<SignInWithGoogleUseCase>();
}

/// Provider del caso de uso para obtener usuario actual
@riverpod
GetCurrentUserUseCase getCurrentUserUseCase(Ref ref) {
  return getIt<GetCurrentUserUseCase>();
}

/// Provider del caso de uso para cerrar sesión
@riverpod
SignOutUseCase signOutUseCase(Ref ref) {
  return getIt<SignOutUseCase>();
}

/// Provider del estado de autenticación
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<User?> build() async {
    // Cargar usuario actual al inicializar
    final useCase = ref.read(getCurrentUserUseCaseProvider);
    return await useCase();
  }

  /// Inicia sesión con Google
  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final useCase = ref.read(signInWithGoogleUseCaseProvider);
      final user = await useCase();
      state = AsyncValue.data(user);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Cierra sesión
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      final useCase = ref.read(signOutUseCaseProvider);
      await useCase();
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
