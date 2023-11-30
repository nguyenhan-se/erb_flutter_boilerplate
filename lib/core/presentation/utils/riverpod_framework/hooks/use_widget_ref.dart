import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// NOTE: using useWidgetRef hook
// https://github.com/rrousselGit/riverpod/issues/2945
WidgetRef useWidgetRef() => useContext() as WidgetRef;
