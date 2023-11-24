import 'package:env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_env_service.g.dart';

@riverpod
EnvFlavor appEnvService(AppEnvServiceRef ref) {
  return EnvFlavor();
}
