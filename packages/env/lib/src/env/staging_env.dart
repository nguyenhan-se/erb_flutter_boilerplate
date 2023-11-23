import 'package:envied/envied.dart';
import 'config/env_fields.dart';
import 'config/env_flavor.dart';

part 'staging_env.g.dart';

@Envied(name: 'Env', path: '.env.staging', allowOptionalFields: true)
class StagingEnv implements EnvFlavor, EnvFields {
  const StagingEnv();

  // Using nullable types or providing a default value for everything allows
  // the app to be build without setting up the .env file. This would be
  // useful for someone who wants to build the app without setting up cloud services.

  @override
  @EnviedField(varName: 'BASE_URL')
  final String? baseUrl = _Env.baseUrl;
}
