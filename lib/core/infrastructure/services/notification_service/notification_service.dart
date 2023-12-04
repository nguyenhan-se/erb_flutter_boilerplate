import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/permission/permission.dart';

import 'fcm_provider.dart';

part 'notification_service.g.dart';

@Riverpod(keepAlive: true)
NotificationService notificationService(NotificationServiceRef ref) {
  final fcm = ref.watch(fcmProvider);

  return NotificationService(
    flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
    firebaseMessaging: fcm,
  );
}

class NotificationService {
  NotificationService({
    required this.flutterLocalNotificationsPlugin,
    required this.firebaseMessaging,
  });

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final FirebaseMessaging? firebaseMessaging;

  Future<void> init({
    required DidReceiveNotificationResponseCallback onNotificationTap,
  }) async {
    await _init(onNotificationTap);
    final token = await firebaseMessaging?.getToken();
    debugPrint('Device FCM token: $token');
    _listenForPushNotifications();
  }

  Future<void> _init(
      DidReceiveNotificationResponseCallback onNotificationTap) async {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: onNotificationTap,
    );
    await firebaseMessaging?.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<bool> _requestPermission() async {
    final notificationPermission = NotificationPermission();
    await notificationPermission.request();
    return await notificationPermission.isGranted;
  }

  Future<void> triggerLocalNotification({
    required DidReceiveNotificationResponseCallback onPressed,
    required VoidCallback onError,
  }) async {
    final hasPermission = await _requestPermission();
    if (!hasPermission) {
      onError();
      return;
    }
    await _init(onPressed);
    await _showNotification(id: 0, title: 'Tap me to finish the quiz!');
  }

  Future<void> triggerPushNotification({
    required DidReceiveNotificationResponseCallback onPressed,
  }) async {
    final hasPermission = await _requestPermission();
    if (!hasPermission) {
      return;
    }
    await _init(onPressed);
    final fcmToken = await firebaseMessaging?.getToken();
    print("fcmToken ====> $fcmToken");
    // await http.post(
    //   Uri.parse(
    //     'https://us-central1-patrol-poc.cloudfunctions.net/sendNotification',
    //   ),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({'token': fcmToken}),
    // );
  }

  void _listenForPushNotifications() {
    if (firebaseMessaging == null) {
      return;
    }

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        final notification = message.notification;
        final messageData = message.data;

        _showNotification(
          id: notification.hashCode,
          title: notification?.title ?? '',
          body: notification?.body,
          payload: jsonEncode(messageData),
        );
      }
    });
  }

  Future<void> _showNotification({
    required int id,
    required String title,
    String? body,
    String? payload,
  }) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'local_push_notification',
        'Drvn pakn Notifications',
        importance: Importance.max,
        priority: Priority.high,
        // color: AppStaticColors.primary,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        interruptionLevel: InterruptionLevel.active,
      ),
    );

    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }
}
