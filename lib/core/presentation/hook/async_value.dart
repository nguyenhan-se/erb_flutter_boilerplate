import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

AsyncData<T>? useLastValidAsyncData<T>(AsyncValue<T> value) {
  final state = useState<AsyncData<T>?>(null);
  if (value is AsyncData<T>) {
    state.value = value;
  } else if (value is AsyncError) {
    state.value = null;
  }
  return state.value;
}
