import 'package:envied/envied.dart';
import 'config/env_fields.dart';
import 'config/env_flavor.dart';

part 'local_env.g.dart';

@Envied(name: 'Env', path: '.env.local', allowOptionalFields: true)
class LocalEnv implements EnvFlavor, EnvFields {
  const LocalEnv();

  // Using nullable types or providing a default value for everything allows
  // the app to be build without setting up the .env file. This would be
  // useful for someone who wants to build the app without setting up cloud services.

  @override
  @EnviedField(varName: 'BASE_URL')
  final String? baseUrl = _Env.baseUrl;
}
