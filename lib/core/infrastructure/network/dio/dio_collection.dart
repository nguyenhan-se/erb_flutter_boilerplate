import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:env/env.dart';
import 'package:erb_shared/extensions.dart';
import 'package:erb_shared/network.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/presentation/providers/talker_log/talker_provider.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/network/dio/interceptors/movie_header_attachment_interceptor.dart';

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
    ).let(
      (dio) => dio
        ..interceptors.addAll([
          RetryInterceptor(
            dio: dio,
            retries: 3, // retry count (optional)
            retryDelays: const [
              // set delays between retries (optional)
              Duration(seconds: 1), // wait 1 sec before the first retry
              Duration(seconds: 2), // wait 2 sec before the second retry
              Duration(seconds: 3), // wait 3 sec before the third retry
            ],
          )
        ]),
    ),
    movie: createDio(
      baseOptions: BaseOptions(baseUrl: EnvFlavor().tmdbUrl),
      interceptors: [
        DioLoggerInterceptor(ref.watch(talkerProvider)),
        ref.watch(movieHeaderAttachmentInterceptorProvider),
      ],
    ),
  );
}

class DioCollection {
  DioCollection({
    required this.movie,
    required this.mockDummyjson,
  });

  final Dio movie;
  final Dio mockDummyjson;
}
