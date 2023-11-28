import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_lifecycle_provider.g.dart';

@Riverpod(keepAlive: true)
AppLifecycleState appLifeCycle(AppLifeCycleRef ref) {
  final observer = _AppLifecycleObserver((value) => ref.state = value);

  final binding = WidgetsBinding.instance..addObserver(observer);
  ref
    ..onDispose(() => binding.removeObserver(observer))
    ..listenSelf((previous, next) => ref
        // .read(talkerProvider)
        // .logTyped(AppLifeCycleLog('$previous -> $next')),
        );
  return AppLifecycleState.resumed;
}

class _AppLifecycleObserver extends WidgetsBindingObserver {
  _AppLifecycleObserver(this._didChangeState);

  final ValueChanged<AppLifecycleState> _didChangeState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _didChangeState(state);
    super.didChangeAppLifecycleState(state);
  }
}

extension AppLifecycleStateExtension on AppLifecycleState {
  bool get isResumed => this == AppLifecycleState.resumed;
}
