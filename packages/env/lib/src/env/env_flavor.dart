import 'package:env/src/env/env_fields.dart';

import '../flavor.dart';
import 'impl/env_dev.dart';
import 'impl/env_local.dart';
import 'impl/env_prod.dart';
import 'impl/env_staging.dart';

abstract class EnvFlavor implements EnvFields {
  static EnvFlavor? _instance;

  // NOTE: When modifying the .env file, the generator might not pick up the
  // change due to dart-lang/build#967. If that happens simply clean the build
  // cache and run the generator again.
  //
  // ```
  // dart run build_runner clean
  // dart run build_runner build --delete-conflicting-outputs
  // ```
  //
  // https://github.com/petercinibulk/envied/issues/6
  factory EnvFlavor() {
    return _instance ??= switch (AppFlavor.fromEnvironment) {
      Flavor.prod || Flavor.beta => const EnvProd(),
      Flavor.staging => const EnvStaging(),
      Flavor.dev => const EnvDev(),
      Flavor.local => const EnvLocal(),
    };
  }
}
