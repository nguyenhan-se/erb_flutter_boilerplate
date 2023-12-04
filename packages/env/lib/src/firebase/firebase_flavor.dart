import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

import '../flavor.dart';
import 'firebase_options_dev.dart' as dev;

abstract class FirebaseFlavor {
  static FirebaseOptions get getFirebaseOptions {
    switch (AppFlavor.fromEnvironment) {
      case Flavor.prod || Flavor.beta:
        return dev.DefaultFirebaseOptions.currentPlatform;
      case Flavor.staging:
        return dev.DefaultFirebaseOptions.currentPlatform;
      case Flavor.dev:
      case Flavor.local:
      default:
        return dev.DefaultFirebaseOptions.currentPlatform;
    }
  }
}
