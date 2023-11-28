import 'package:dio/dio.dart';
import 'package:erb_shared/network.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/presentation/providers/talker_log/talker_provider.dart';

import 'interceptors/dio_logger_interceptor.dart';

part 'dio_collection.g.dart';

@Riverpod(keepAlive: true)
DioCollection dio(DioRef ref) {
  // final appEnv = ref.watch(appEnvServiceProvider);

  return DioCollection(
    mockDummyjson: createDio(
      baseOptions: BaseOptions(baseUrl: 'https://dummyjson.com'),
      interceptors: [
        DioLoggerInterceptor(ref.watch(talkerProvider)),
      ],
    ),
    mockJsonplaceholder: createDio(
      baseOptions: BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'),
      interceptors: [
        DioLoggerInterceptor(ref.watch(talkerProvider)),
      ],
    ),
  );
}

class DioCollection {
  DioCollection({
    required this.mockJsonplaceholder,
    required this.mockDummyjson,
  });

  final Dio mockJsonplaceholder;
  final Dio mockDummyjson;
}
