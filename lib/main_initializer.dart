import 'package:env/env.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'core/features/app_settings/data/app_settings_repo.dart';
import 'core/features/authentication/data/auth_repo.dart';
import 'core/features/app_settings/domain/app_settings.dart';
import 'core/features/authentication/domain/auth_credential.dart';
import 'core/presentation/providers/talker_provider.dart';

Future<ProviderContainer> mainInitializer() async {
  WidgetsFlutterBinding.ensureInitialized();

  // * Register error handlers. For more info, see:
  // * https://docs.flutter.dev/testing/errors
  final talker = TalkerFlutter.init(
    settings: TalkerSettings(
      useConsoleLogs: !kReleaseMode,
      enabled: !kReleaseMode,
    ),
    logger: TalkerLogger(
      output: debugPrint,
      settings: const TalkerLoggerSettings(),
    ),
  );

  registerErrorHandlers(talker);
  AppFlavor.initConfig();

  await initHive();

  // Config for OS
  // if (!kIsWeb &&
  //     (io.Platform.isWindows || io.Platform.isLinux || io.Platform.isMacOS)) {
  //   await windowManager.ensureInitialized();
  //   await windowManager.setMinimumSize(const Size(100, 200));
  // }

  final container = ProviderContainer(
    observers: [],
    overrides: [
      talkerProvider.overrideWithValue(talker),
    ],
  );

  return container;
}

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(AppSettingsAdapter());
  Hive.registerAdapter(AuthCredentialAdapter());

  await Future.wait([
    AppSettingsRepo.prepare(),
    AuthRepo.prepare(),
  ]);
}

/// Source: Flutter Foundations course by CodeWithAndrea
void registerErrorHandlers(Talker talker) {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    talker.handle(details.exception, details.stack, 'Uncaught fatal exception');
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stackTrace) {
    talker.handle(error, stackTrace, 'Uncaught async exception');
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in teh app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('An error occured'),
          backgroundColor: Colors.red,
        ),
        // Body with the error message and button to restart the app
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Text(details.exceptionAsString(),
                    style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                const Text('Restart the app to continue.',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  };
}
