import 'package:firebase_core/firebase_core.dart';
import 'package:futbolitonew/core/environment/env.dart';
import 'package:futbolitonew/core/environment/env_entity.dart';
import 'package:futbolitonew/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:futbolitonew/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:futbolitonew/features/auth/domain/repositories/auth_repository.dart';
import 'package:futbolitonew/firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  /// Environment
  getIt.registerSingleton<IEnvironment>(EnvironmentProd());

  /// External Services
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: getIt<IEnvironment>().supabase['url']!,
    anonKey: getIt<IEnvironment>().supabase['anonKey']!,
  );

  /// Auth Feature
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );

  //  getIt.registerSingleton<ApiClient>(ApiClient());
}
