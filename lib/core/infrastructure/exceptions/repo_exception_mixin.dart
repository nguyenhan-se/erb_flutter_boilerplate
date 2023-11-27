mixin RepositoryExceptionMixin {
  Future<O> runAsyncCatching<O>({
    required Future<O> Function() action,
  }) async {
    try {
      final output = await action.call();

      return output;
    } catch (error) {
      rethrow;
    }
  }
}
