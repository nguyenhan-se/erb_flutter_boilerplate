import 'dart:convert';

import 'package:erb_shared/extensions.dart';

import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/services/notification_service/push_notification_service.dart';

void useForegroundAppNotification() async {
  final ref = useWidgetRef();

  final pushNotificationService = ref.watch(pushNotificationServiceProvider);

  useOnStreamChange(pushNotificationService.foregroundMessageStream,
      onData: (message) {
    if (message.notification.isNotNull) {
      final notification = message.notification;
      final messageData = message.data;
      pushNotificationService.showLocal(
        title: notification?.title ?? '',
        body: notification?.body ?? '',
        payload: jsonEncode(messageData),
      );
    }
  });
}
