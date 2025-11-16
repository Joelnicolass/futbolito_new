import 'package:firebase_core/firebase_core.dart';
import 'package:futbolitonew/core/environment/env.dart';
import 'package:futbolitonew/core/environment/env_entity.dart';
import 'package:futbolitonew/core/intl/intl.dart';
import 'package:futbolitonew/features/auth/di/register_dependencies.dart'
    as auth_di;
import 'package:futbolitonew/firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  /// Language
  getIt.registerSingleton<Internationalization>(SpanishInternationalization());

  /// Environment
  getIt.registerSingleton<IEnvironment>(EnvironmentProd());

  /// External Services
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: getIt<IEnvironment>().supabase['url']!,
    anonKey: getIt<IEnvironment>().supabase['anonKey']!,
  );

  /// Features
  auth_di.authRegisterDependencies();

  //  getIt.registerSingleton<ApiClient>(ApiClient());
}
