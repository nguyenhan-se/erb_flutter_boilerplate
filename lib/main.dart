import 'package:env/env.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/features/app_settings/domain/app_settings.dart';
import 'core/features/app_settings/data/app_settings_repo.dart';

import 'app.dart';

part 'main_initializer.dart';

Future<void> main() async {
  final container = await _mainInitializer();

  runApp(ProviderScope(
    parent: container,
    child: const App(),
  ));
}
