import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fcm_provider.g.dart';

@Riverpod(keepAlive: true)
FirebaseMessaging fcm(FcmRef ref) {
  return FirebaseMessaging.instance;
}
