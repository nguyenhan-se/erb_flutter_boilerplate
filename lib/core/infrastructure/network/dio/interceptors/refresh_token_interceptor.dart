import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:erb_shared/erb_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';

import '../../../exceptions/exception.dart';
import '../../../../features/authentication/application/application.dart';

part 'refresh_token_interceptor.g.dart';

@Riverpod(keepAlive: true)
RefreshTokenInterceptor refreshTokenInterceptor(
  RefreshTokenInterceptorRef ref,
) =>
    RefreshTokenInterceptor(ref);

class RefreshTokenInterceptor extends InterceptorsWrapper {
  RefreshTokenInterceptor(this.ref);

  final RefreshTokenInterceptorRef ref;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // todo: Cập nhật dạnh sách endpoint bỏ qua refreshToken ở dưới.
    final skipPaths = ['/api/v1/auth/login', '/api/v1/auth/refresh'];

    final isSkipRefresh = skipPaths.any((e) => e == err.requestOptions.path) ||
        !(err.response?.statusCode == HttpStatus.unauthorized) ||
        (err.requestOptions.headers['Authorization']?.toString()).isNullOrEmpty;

    if (isSkipRefresh) return handler.next(err);

    final options = err.response!.requestOptions;
    _onExpiredToken(options, handler);
  }

  var _isRefreshing = false;
  final _queue = Queue<(RequestOptions, ErrorInterceptorHandler)>();

  void _onExpiredToken(
    RequestOptions options,
    ErrorInterceptorHandler handler,
  ) {
    _queue.addLast((options, handler));
    if (!_isRefreshing) {
      _isRefreshing = true;
      _refreshToken()
          .then(_onRefreshTokenSuccess)
          .catchError(_onRefreshTokenError)
          .whenComplete(() {
        _isRefreshing = false;
        _queue.clear();
      });
    }
  }

  Future<String> _refreshToken() async {
    _isRefreshing = true;
    final authState = ref.read(authStateProvider);
    return authState.match(
      () => throw const RemoteException(
          kind: RemoteExceptionKind.refreshTokenFailed),
      (auth) {
        // todo: Gọi Api refresh token ở đây
        //   return ref
        //       .read(authRepoProvider)
        //       .refreshToken(AuthCredential(
        //         token: auth.token,
        //         refreshToken: auth.refreshToken,
        //       ))
        //       .then((value) => value.token);
        const newAccessToken = 'access token';
        return newAccessToken;
      },
    );
  }

  Future<void> _onRefreshTokenSuccess(String newToken) {
    return Future.wait(_queue.map(
      (requestInfo) =>
          _requestWithNewToken(requestInfo.$1, requestInfo.$2, newToken),
    ));
  }

  Future<void> _onRefreshTokenError(Object? error, s) async {
    final appRouter = ref.read(appRouterProvider);

    // todo: Cập nhật logic navigate theo yêu cầu, mặc định là di chuyển về màn login
    await appRouter.replaceAll([SignInRoute()]);
    ref.read(authStateProvider.notifier).unAuthenticateUser();
  }

  Future<void> _requestWithNewToken(
    RequestOptions options,
    ErrorInterceptorHandler handler,
    String newAccessToken,
  ) async {
    options.headers['Authorization'] = 'Bearer $newAccessToken';
    try {
      final dio = createDio(baseOptions: BaseOptions(baseUrl: options.baseUrl));
      final httpOptions = Options(
        method: options.method,
        headers: options.headers,
      );

      final response = await dio.request<dynamic>(
        options.path,
        data: options.data,
        queryParameters: options.queryParameters,
        options: httpOptions,
      );

      return handler.resolve(response);
    } catch (e, s) {
      return handler.next(DioException(
        requestOptions: options,
        error: e,
        stackTrace: s,
      ));
    }
  }
}
