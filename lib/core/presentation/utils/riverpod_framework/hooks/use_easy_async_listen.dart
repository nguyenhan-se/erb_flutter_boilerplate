import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import 'use_widget_ref.dart';

void useEasyAsyncListen<T>(
  ProviderListenable<AsyncValue<T>> provider, {
  bool handleError = true,
  void Function(T data)? whenData,
}) {
  final widgetRef = useWidgetRef();

  widgetRef.easyAsyncListen(
    provider,
    handleError: handleError,
    whenData: whenData,
  );
}
