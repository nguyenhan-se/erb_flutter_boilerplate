import 'package:env/src/env/env_fields.dart';

import '../flavor.dart';
import 'impl/env_dev.dart';
import 'impl/env_local.dart';
import 'impl/env_prod.dart';
import 'impl/env_staging.dart';

abstract class EnvFlavor implements EnvFields {
  static EnvFlavor? _instance;

  factory EnvFlavor() {
    return _instance ??= switch (AppFlavor.fromEnvironment) {
      Flavor.prod || Flavor.beta => const EnvProd(),
      Flavor.staging => const EnvStaging(),
      Flavor.dev => const EnvDev(),
      Flavor.local => const EnvLocal(),
    };
  }
}
