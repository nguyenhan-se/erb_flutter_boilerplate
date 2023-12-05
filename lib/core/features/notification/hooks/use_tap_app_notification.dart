import 'dart:convert';

import 'package:erb_shared/extensions.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/services/notification_service/push_notification_service.dart';

import '../domain/app_notification.dart';

void useTapAppNotification() {
  final ref = useWidgetRef();
  final context = useContext();

  final pushNotificationService = ref.watch(pushNotificationServiceProvider);

  useOnStreamChange(
    pushNotificationService.localNotifications,
    onData: (payload) {
      final decodedPayload = jsonDecode(payload) as Map<String, dynamic>;
      if (decodedPayload.isNotEmpty) {
        final ntf = AppNotification.fromJson(decodedPayload);
        AutoRouter.of(context).navigateNamed(ntf.path);
      }
    },
  );

  useOnStreamChange(
    pushNotificationService.onMessageOpenedApp,
    onData: (message) {
      if (message.notification.isNotNull) {
        final messageData = message.data;
        final ntf = AppNotification.fromJson(messageData);
        AutoRouter.of(context).navigateNamed(ntf.path);
      }
    },
  );
}
