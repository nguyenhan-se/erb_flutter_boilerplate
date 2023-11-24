import 'package:dio/dio.dart';
import 'package:erb_shared/network.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DioLoggerInterceptor extends BaseInterceptor {
  final talkerDioLog = TalkerDioLogger(
    settings: const TalkerDioLoggerSettings(
      printRequestHeaders: true,
      printResponseHeaders: true,
    ),
  );

  @override
  int get priority => BaseInterceptor.customLogPriority;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) =>
      talkerDioLog.onRequest(options, handler);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) =>
      talkerDioLog.onResponse(response, handler);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) =>
      talkerDioLog.onError(err, handler);
}
