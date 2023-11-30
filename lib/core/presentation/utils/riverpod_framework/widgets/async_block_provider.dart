import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/exceptions/exception.dart';

import 'async_value_block.dart';

class AsyncBlockProvider<T> extends HookConsumerWidget {
  const AsyncBlockProvider({
    required this.provider,
    required this.data,
    this.complete,
    this.error,
    this.loading,
    this.empty,
    this.retry,
    this.handleError = true,
    super.key,
  });

  final ProviderListenable<AsyncValue<T>> provider;

  final Widget Function(T) data;
  final Widget Function(Object, StackTrace?)? error;
  final Widget Function()? loading;
  final Widget Function()? empty;
  final void Function(BuildContext context, T data)? complete;

  final VoidCallback? retry;
  final bool handleError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenManual(
      provider,
      (prevState, newState) {
        newState.whenOrNull(
          skipLoadingOnRefresh: false,
          error: handleError
              ? (err, st) => Dialogs.showAlertDialog(
                    context,
                    dialogType: DialogType.error,
                    message: err.errorMessage(context),
                  )
              : null,
          data: (data) => complete?.call(context, data),
        );
      },
    );

    return AsyncValueBlock<T>(
      value: ref.watch(provider),
      data: data,
      empty: empty,
      error: error,
      loading: loading,
      retry: retry,
    );
  }
}
