import 'dart:async';

import 'package:erb_shared/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'push_notification_service.g.dart';

@Riverpod(keepAlive: true)
PushNotificationService pushNotificationService(
    PushNotificationServiceRef ref) {
  return PushNotificationService(reset: true);
}

class PushNotificationService {
  static late PushNotificationService _service;

  late final FirebaseMessaging _firebase;
  late final FlutterLocalNotificationsPlugin _notificationsPlugin;
  final StreamController<String> _localNotificationClickStream =
      StreamController.broadcast();

  factory PushNotificationService({required bool reset}) {
    if (reset) {
      _service = PushNotificationService._();
    }
    return _service;
  }

  PushNotificationService._() {
    // Get firebase instance
    _firebase = FirebaseMessaging.instance;

    //  Get local notifications plugin instance
    _notificationsPlugin = FlutterLocalNotificationsPlugin();

    // Set up local notifications settings
    // ic_notification can be swapped for another drawable resource
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

    // Initialize the local notifications plugin with above settings
    _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            if (notificationResponse.payload == null) return;

            _localNotificationClickStream.sink
                .add(notificationResponse.payload!);
            break;
          case NotificationResponseType.selectedNotificationAction:
            //   SocketIOService _socketio = SocketIOService.instance;
            //   _socketio.emitTestEvent();
            break;
        }
      }, //onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
    );
  }

  static PushNotificationService get instance => _service;

  void requestPermission() async {
    // Request permissions for firebase
    if (isIOS) await _firebase.requestPermission();

    // Request permissions for local notifications
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          sound: true,
          alert: true,
          badge: true,
        );
  }

  // Returns a stream of notifications received,
  // while the application is in the foreground
  Stream<RemoteMessage> get foregroundMessageStream {
    return FirebaseMessaging.onMessage;
  }

  // Returns a stream of notifications which was pressed on,
  // while the application was in background
  Stream<RemoteMessage> get onMessageOpenedApp {
    return FirebaseMessaging.onMessageOpenedApp;
  }

  // Returns a stream of events when user clicks on local notifications
  Stream<String> get localNotifications => _localNotificationClickStream.stream;

  // Should be called to check whether the app was started up
  // (from terminated state) via user click on notification
  Future<RemoteMessage?> get checkRemoteNotificationClick async {
    final remoteMessage = await _firebase.getInitialMessage();

    if (remoteMessage == null) return null;

    return remoteMessage;
  }

  Future<String?> get checkLocalNotificationClick async {
    final details =
        await _notificationsPlugin.getNotificationAppLaunchDetails();

    // Not null guaranteed on android and iOS
    if (!details!.didNotificationLaunchApp) return null;
    if (details.notificationResponse == null) return null;
    final payload = details.notificationResponse!.payload;
    if (payload != null) {
      return payload;
    }

    return null;
  }

  // Delivers local notification, and returns its ID
  int showLocal({
    required String title,
    required String body,
    String? payload,
  }) {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'local_push_notification',
        'Drvn pakn Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
        // color: AppStaticColors.primary,
        enableLights: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
        presentBadge: true,
      ),
    );
    final int id = DateTime.now().millisecondsSinceEpoch % 0xFFFFFF;

    _notificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );

    return id;
  }

  Future<void> cancelLocal({required int id}) =>
      _notificationsPlugin.cancel(id);

  Future<void> dispose() async {
    await _localNotificationClickStream.close();
  }
}
