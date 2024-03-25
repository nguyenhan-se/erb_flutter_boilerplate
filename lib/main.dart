import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app.dart';
import 'i18n/i18n.dart';
import 'main_initializer.dart';

Future<void> main() async {
  final container = await mainInitializer();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: ResponsiveBreakpoints.builder(
        breakpoints: const [
          Breakpoint(start: 0, end: 450, name: MOBILE),
          Breakpoint(start: 451, end: 800, name: TABLET),
          Breakpoint(start: 801, end: 1920, name: DESKTOP),
          Breakpoint(start: 1921, end: double.infinity, name: '4k'),
        ],
        child: TranslationProvider(child: const App()),
      ),
    ),
  );
}
