import 'package:dio/dio.dart';
import 'package:erb_shared/network.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioLoggerInterceptor extends BaseInterceptor {
  final prettyDioLogger = PrettyDioLogger();

  @override
  int get priority => BaseInterceptor.customLogPriority;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) =>
      prettyDioLogger.onRequest(options, handler);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) =>
      prettyDioLogger.onResponse(response, handler);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) =>
      prettyDioLogger.onError(err, handler);
}
