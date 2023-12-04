import 'package:erb_shared/extensions.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/services/notification_service/notification_service.dart';

void useTapAppNotification() {
  final ref = useWidgetRef();

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    if (message.notification != null) {
      // final notification = message.notification;
      final messageData = message.data;

      print("come here onMessageOpenedApp ====>  ${messageData}");

      // _showNotification(
      //   id: notification.hashCode,
      //   title: notification?.title ?? '',
      //   body: notification?.body,
      //   payload: jsonEncode(messageData),
      // );
    }
  });

  // ignore: avoid_single_cascade_in_expression_statements
  ref.watch(notificationServiceProvider)
    ..init(onNotificationTap: (details) {
      if (details.payload.isNotNull) {
        print(
            "come here  notificationServiceProvider====>  ${details.payload}");
      }
    });
}
