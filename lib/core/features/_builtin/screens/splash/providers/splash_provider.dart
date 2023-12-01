import 'package:flutter/foundation.dart';
import 'package:erb_shared/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/network/network_info.dart';
import 'package:erb_flutter_boilerplate/core/features/authentication/application/application.dart';

part 'splash_provider.g.dart';

@riverpod
Future<void> splashServicesWarmup(SplashServicesWarmupRef ref) async {
  final min =
      Future<void>.delayed(const Duration(seconds: 1)); //Min Time of splash

  final s3 = Future<void>(() async {
    if (!kIsWeb) {
      // await ref.watch(setupFlutterLocalNotificationsProvider.future);
      // await ref.watch(setupFCMProvider.future);
    }
  });
  final s4 = ref.watch(checkAuthProvider.future).suppressError();

  await [min, s3, s4].wait.throwAllErrors();
}

@riverpod
Future<PageRouteInfo> splashTarget(SplashTargetRef ref) async {
  final hasInternetConnection =
      await ref.watch(networkInfoProvider).hasInternetConnection;

  if (hasInternetConnection) {
    return const AppControllerRoute();
  } else {
    return const NoInternetRoute();
  }
}
