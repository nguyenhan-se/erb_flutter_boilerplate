import 'package:dio/dio.dart';
import 'package:erb_shared/network.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../services/app_env_service.dart';
import 'interceptors/dio_logger_interceptor.dart';

part 'dio_collection.g.dart';

@Riverpod(keepAlive: true)
DioCollection dio(DioRef ref) {
  final appEnv = ref.watch(appEnvServiceProvider);

  return DioCollection(
    mock: createDio(
      baseOptions: BaseOptions(baseUrl: appEnv.baseUrl),
      interceptors: [DioLoggerInterceptor()],
    ),
  );
}

class DioCollection {
  DioCollection({
    required this.mock,
  });

  final Dio mock;
}
