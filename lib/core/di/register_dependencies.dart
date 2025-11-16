import 'package:futbolitonew/core/environment/env.dart';
import 'package:futbolitonew/core/environment/env_entity.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // Registrar Environment
  getIt.registerSingleton<IEnvironment>(EnvironmentProd());

  //  getIt.registerSingleton<ApiClient>(ApiClient());
}
