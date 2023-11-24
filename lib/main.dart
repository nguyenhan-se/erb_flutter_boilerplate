import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'main_initializer.dart';

Future<void> main() async {
  final container = await mainInitializer();

  runApp(
    ProviderScope(
      parent: container,
      child: const App(),
    ),
  );
}
