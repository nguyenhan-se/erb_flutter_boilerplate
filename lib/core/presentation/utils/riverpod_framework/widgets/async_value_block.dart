import 'package:erb_ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/exceptions/exception.dart';

/// Simple wrapper around [AsyncValue] to render standardized
/// widgets for different states (loading, error, empty)
class AsyncValueBlock<T> extends StatelessWidget {
  const AsyncValueBlock({
    super.key,
    required this.value,
    required this.data,
    this.error,
    this.loading,
    this.empty,
    this.retry,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function(Object, StackTrace?)? error;
  final Widget Function()? loading;
  final Widget Function()? empty;
  final VoidCallback? retry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: _buildDataOrEmptyWidget,
      error: error ?? _defaultError,
      loading: loading ?? _defaultLoad,
    );
  }

  /// Renders the [data] widget, or falls back to the [empty] widget
  /// (if any & needed)
  Widget _buildDataOrEmptyWidget(T unwrappedData) {
    if (empty == null) {
      // Always render data widget if no empty state specified
      return data(unwrappedData);
    }
    if (unwrappedData == null ||
        (unwrappedData is List && unwrappedData.isEmpty)) {
      return empty!();
    }
    return data(unwrappedData);
  }

  Widget _defaultError(Object error, StackTrace st) {
    // return Center(child: Text(e.toString()));
    return HookConsumer(builder: (context, ref, child) {
      final t = useI18n();

      return ERbOopsError(
        text: error.errorMessage(context),
        button: retry != null
            ? TextButton(
                onPressed: retry,
                child: Text(t.common.retry),
              )
            : null,
      );
    });
  }

  Widget _defaultLoad() {
    return const Center(child: CircularProgressIndicator());
  }
}
