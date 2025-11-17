import 'package:futbolitonew/common/domain/entities/environment_entity.dart';

class EnvironmentDev implements IEnvironment {
  @override
  Map<String, String> supabase = {"url": '', "anonKey": ''};
}
