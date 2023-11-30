import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/exceptions/exception.dart';

extension WidgetRefExtension on WidgetRef {
  bool isLoading<T>(ProviderListenable<AsyncValue<T>> provider) {
    return watch(provider.select((AsyncValue<T> s) => s.isLoading));
  }

  /// Listen to a provider while easy handling Loading/Error dialogs.
  ///
  /// You can set handleLoading/handleError to false to turn off auto handling for either of them.
  ///
  /// Use `whenData` If you want to perform something when the newState is data.
  void easyAsyncListen<T>(
    ProviderListenable<AsyncValue<T>> provider, {
    bool handleError = true,
    void Function(T data)? whenData,
  }) {
    return listen(
      provider,
      (prevState, newState) {
        newState.whenOrNull(
          skipLoadingOnRefresh: false,
          error: handleError
              ? (err, st) {
                  Dialogs.showAlertDialog(
                    context,
                    dialogType: DialogType.error,
                    message: err.errorMessage(context),
                  );
                }
              : null,
          data: whenData,
        );
      },
    );
  }

  /// Keep listening to [AutoDisposeNotifierProvider] until a Future function is complete.
  ///
  /// This method should be called asynchronously, like inside an onPressed.
  /// It shouldn't be used directly inside the build method.
  ///
  /// This is primarily used to initialize and preserve the state of the provider
  /// when navigating to a route until that route is popped off.
  ///
  /// Note: for Navigator 2.0 use "AutoDisposeRefExtension.keepAliveUntilNoListeners"
  Future<void> listenWhile<NotifierT extends AutoDisposeNotifier<T>, T>(
    AutoDisposeNotifierProvider<NotifierT, T> provider,
    Future<void> Function(NotifierT notifier) cb,
  ) async {
    final sub = listenManual(provider, (_, __) {});
    try {
      return await cb(read(provider.notifier));
    } finally {
      sub.close();
    }
  }
}
