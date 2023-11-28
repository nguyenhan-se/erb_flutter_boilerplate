import 'package:app_constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:erb_shared/network.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DioLoggerInterceptor extends BaseInterceptor {
  final Talker talker;
  late final TalkerDioLogger talkerDio;

  DioLoggerInterceptor(this.talker) {
    talkerDio = TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: LogSettings.enableDioResponseData,
        printResponseHeaders: LogSettings.enableDioResponseHeaders,
        printResponseMessage: LogSettings.enableDioResponseMessage,
        printRequestData: LogSettings.enableDioRequestData,
        printRequestHeaders: LogSettings.enableDioRequestHeaders,
      ),
    );
  }

  @override
  int get priority => BaseInterceptor.customLogPriority;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) =>
      talkerDio.onRequest(options, handler);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) =>
      talkerDio.onResponse(response, handler);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) =>
      talkerDio.onError(err, handler);
}
