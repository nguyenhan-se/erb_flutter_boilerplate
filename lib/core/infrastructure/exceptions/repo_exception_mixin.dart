import 'package:dio/dio.dart';

import '_interface/remote/remote_exception.dart';
import 'exception_mapper/dio_exception_mapper.dart';

mixin RepositoryExceptionMixin {
  Future<O> runAsyncCatching<O>({
    required Future<O> Function() action,
  }) async {
    try {
      final output = await action.call();

      return output;
    } on DioException catch (error) {
      throw _remoteErrorMapper(error);
    } catch (error) {
      rethrow;
    }
  }

  RemoteException _remoteErrorMapper(Object error) {
    throw DioExceptionMapper().map(error);
  }
}
