import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:futbolitonew/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';
import 'package:futbolitonew/features/auth/domain/usecases/delete_fcm_token_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/delete_user_fcm_tokens_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/get_user_from_supabase_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/register_fcm_token_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_in_with_apple_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_out_usecase.dart';

void authRegisterDependencies() {
  /// DataSources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  /// Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );

  /// Use Cases
  getIt.registerLazySingleton<SignInWithGoogleUseCase>(
    () => SignInWithGoogleUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignInWithAppleUseCase>(
    () => SignInWithAppleUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<RegisterUserUseCase>(
    () => RegisterUserUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<GetUserFromSupabaseUseCase>(
    () => GetUserFromSupabaseUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<RegisterFcmTokenUseCase>(
    () => RegisterFcmTokenUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<DeleteFcmTokenUseCase>(
    () => DeleteFcmTokenUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<DeleteUserFcmTokensUseCase>(
    () => DeleteUserFcmTokensUseCase(getIt<AuthRepository>()),
  );
}
