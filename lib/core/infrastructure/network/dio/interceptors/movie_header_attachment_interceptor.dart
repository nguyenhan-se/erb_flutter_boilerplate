import 'package:dio/dio.dart';
import 'package:env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_header_attachment_interceptor.g.dart';

@Riverpod(keepAlive: true)
MovieHeaderAttachmentInterceptor movieHeaderAttachmentInterceptor(
  MovieHeaderAttachmentInterceptorRef ref,
) {
  return MovieHeaderAttachmentInterceptor(ref);
}

class MovieHeaderAttachmentInterceptor extends InterceptorsWrapper {
  MovieHeaderAttachmentInterceptor(this.ref);

  final MovieHeaderAttachmentInterceptorRef ref;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers
        .putIfAbsent('Authorization', () => 'Bearer ${EnvFlavor().tmdbToken}');
    return handler.next(options);
  }
}
