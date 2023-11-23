import 'package:envied/envied.dart';
import 'config/env_fields.dart';
import 'config/env_flavor.dart';

part 'dev_env.g.dart';

@Envied(name: 'Env', path: '.env.dev', allowOptionalFields: true)
class DevEnv implements EnvFlavor, EnvFields {
  const DevEnv();

  // Using nullable types or providing a default value for everything allows
  // the app to be build without setting up the .env file. This would be
  // useful for someone who wants to build the app without setting up cloud services.

  @override
  @EnviedField(varName: 'BASE_URL')
  final String? baseUrl = _Env.baseUrl;
}
