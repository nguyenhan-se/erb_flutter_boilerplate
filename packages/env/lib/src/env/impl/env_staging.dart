import 'package:envied/envied.dart';

import '../env_fields.dart';
import '../env_flavor.dart';

part 'env_staging.g.dart';

@Envied(name: 'Env', path: '.env.staging', allowOptionalFields: true)
class EnvStaging implements EnvFlavor, EnvFields {
  const EnvStaging();

  // Using nullable types or providing a default value for everything allows
  // the app to be build without setting up the .env file. This would be
  // useful for someone who wants to build the app without setting up cloud services.

  @override
  @EnviedField(varName: 'BASE_URL')
  final String baseUrl = _Env.baseUrl;
}
