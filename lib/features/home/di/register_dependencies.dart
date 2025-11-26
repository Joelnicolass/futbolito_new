import 'package:futbolitonew/features/home/data/datasources/remote/remote_datasource.dart';

import '../../../core/di/register_dependencies.dart';

void invitationsRegisterDependencies() {
  /// DataSources
  getIt.registerLazySingleton<InvitationsRemoteDataSource>(
    () => InvitationsRemoteDataSource(),
  );

  /// Repositories
  /* getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  ); */

  /// Use Cases
  /* getIt.registerLazySingleton<SignInWithGoogleUseCase>(
    () => SignInWithGoogleUseCase(getIt<AuthRepository>()),
  ); */
}
