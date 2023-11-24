import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:env/env.dart';

part 'app_env_service.g.dart';

@riverpod
EnvFlavor appEnvService(AppEnvServiceRef ref) {
  return EnvFlavor();
}
