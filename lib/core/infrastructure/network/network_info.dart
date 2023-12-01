import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'network_info.g.dart';

@Riverpod(keepAlive: true)
NetworkInfo networkInfo(NetworkInfoRef ref) {
  return NetworkInfo(
    InternetConnection(),
  );
}

@riverpod
Stream<InternetStatus> internetConnectionChange(
    InternetConnectionChangeRef ref) {
  final statusStream = ref.watch(networkInfoProvider).onStatusChange;

  return statusStream.distinct((previous, next) {
    //Compare prev,next streams by deep equals and skip if they're not equal,
    //while ignoring deliveryGeoPoint in Order entity's equality implementation.
    //This avoid updating the stream when the delivery updates his own deliveryGeoPoint
    //which will lead to unnecessary api calls.
    return previous == next;
  });
}

class NetworkInfo {
  NetworkInfo(this.internetConnection);

  final InternetConnection internetConnection;

  Future<bool> get hasInternetConnection =>
      internetConnection.hasInternetAccess;

  Stream<InternetStatus> get onStatusChange =>
      internetConnection.onStatusChange;
}
