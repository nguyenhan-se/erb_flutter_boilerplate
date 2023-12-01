import '_interface/base/app_exception.dart';
import '_interface/remote/remote_exception.dart';
import '_interface/local_service/local_service_exception.dart';

import 'package:erb_flutter_boilerplate/i18n/i18n.dart';

class AppExceptionMessage {
  const AppExceptionMessage();

  static String map(AppException appException, I18n t) {
    return switch (appException.appExceptionType) {
      AppExceptionType.remote => switch (
            (appException as RemoteException).kind) {
          RemoteExceptionKind.badCertificate =>
            t.exception.remote.badCertificate,
          RemoteExceptionKind.noInternet =>
            t.exception.remote.noInternetException,
          RemoteExceptionKind.network => t.exception.remote.noInternetException,
          RemoteExceptionKind.serverDefined =>
            appException.generalServerMessage ?? t.exception.unknownException,
          RemoteExceptionKind.serverUndefined =>
            appException.generalServerMessage ?? t.exception.unknownException,
          RemoteExceptionKind.timeout => t.exception.remote.noInternetException,
          RemoteExceptionKind.cancellation =>
            t.exception.remote.cancellationException,
          RemoteExceptionKind.unknown =>
            '${t.exception.unknownException}: ${appException.rootException}',
          RemoteExceptionKind.refreshTokenFailed =>
            t.exception.remote.tokenExpired,
        },
      AppExceptionType.uncaught => t.exception.unknownException,
      AppExceptionType.localService => switch (
            (appException as LocalServiceException).kind) {
          LocalServiceExceptionKind.biometric => appException.message,
          LocalServiceExceptionKind.unknown => t.exception.unknownException,
        },
    };
  }
}
