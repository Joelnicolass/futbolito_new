import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/features/auth/domain/entities/user.dart';
import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_in_with_google_usecase.dart';

part 'auth_provider.g.dart';

/// Provider del repositorio de autenticación
@riverpod
AuthRepository authRepository(Ref ref) {
  return getIt<AuthRepository>();
}

/// Provider del caso de uso de inicio de sesión con Google
@riverpod
SignInWithGoogleUseCase signInWithGoogleUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignInWithGoogleUseCase(repository);
}

/// Provider del estado de autenticación
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<User?> build() async {
    // Cargar usuario actual al inicializar
    final repository = ref.read(authRepositoryProvider);
    return await repository.getCurrentUser();
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
      final repository = ref.read(authRepositoryProvider);
      await repository.signOut();
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
