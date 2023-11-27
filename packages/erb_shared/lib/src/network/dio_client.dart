import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'interceptors/base_interceptor.dart';

Dio createDio({
  required BaseOptions baseOptions,
  List<Interceptor> interceptors = const [],
  Transformer? transformer,
}) {
  final dio = Dio();

  // if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
  //   /// Allows https requests for older devices.
  //   (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
  //       (HttpClient client) {
  //     client.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;

  //     return client;
  //   };
  // }

  // dio.httpClientAdapter = IOHttpClientAdapter(
  //   createHttpClient: () {
  //     final client = HttpClient();
  //     client.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => false;
  //     return client;
  //   },
  // );

  dio
    ..options.baseUrl = baseOptions.baseUrl
    ..options.connectTimeout = baseOptions.connectTimeout
    ..options.receiveTimeout = baseOptions.receiveTimeout
    ..options.headers = {
      'Content-Type': 'application/json; charset=utf-8',
      ...baseOptions.headers
    };
  if (transformer != null) {
    dio.transformer = transformer;
  }

  final sortedInterceptors = interceptors.sortedByDescending((element) {
    return element is BaseInterceptor ? element.priority : -1;
  });

  dio.interceptors.addAll(sortedInterceptors);

  return dio;
}
