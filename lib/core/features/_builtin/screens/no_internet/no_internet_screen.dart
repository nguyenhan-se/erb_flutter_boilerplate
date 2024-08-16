import 'package:flutter/material.dart';
import 'package:erb_shared/extensions.dart';
import 'package:app_constants/app_constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/network/network_info.dart';

@RoutePage()
class NoInternetScreen extends HookConsumerWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = useI18n();

    ref.listen(
      internetConnectionChangeProvider.select((value) => value.valueOrNull),
      (previous, next) {
        if (previous.isNull || next.isNull) return;
        if (previous == InternetStatus.disconnected &&
            next == InternetStatus.connected) {
          Dialogs.showAlertDialog(
            context,
            message: t.system.hasInternetConnection,
            dialogType: DialogType.success,
            barrierDismissible: false,
            onPressed: () {
              AutoRouter.of(context).replaceAll([const SplashRoute()]);
            },
          );
        }
      },
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                t.exception.internet.noInternetConnection,
                textAlign: TextAlign.center,
              ),
              KSizedBox.h16.size,
              Text(
                t.exception.internet.pleaseCheckYourDeviceNetwork,
                textAlign: TextAlign.center,
              ),
              KSizedBox.h16.size,
              HookConsumer(
                builder: (context, ref, child) {
                  final networkInfo = ref.watch(networkInfoProvider);

                  Future<void> retryOnPressed() async {
                    await Future.delayed(const Duration(seconds: 1));
                    await networkInfo.hasInternetConnection.then(
                      (value) {
                        if (value) {
                          // ignore: use_build_context_synchronously
                          AutoRouter.of(context)
                              .replaceAll([const SplashRoute()]);
                        }
                      },
                    );
                  }

                  return AsyncButton(
                    onPressed: retryOnPressed,
                    label: t.common.retry,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
