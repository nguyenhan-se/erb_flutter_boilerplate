import 'package:dart_mappable/dart_mappable.dart';

part 'app_notification.mapper.dart';

@MappableClass()
class AppNotification with AppNotificationMappable {
  final String tabName;
  final String? routeLocation;
  final Map<String, dynamic>? data;

  AppNotification({
    required this.tabName,
    required this.routeLocation,
    required this.data,
  });

  static const fromJson = AppNotificationMapper.fromJson;
}
