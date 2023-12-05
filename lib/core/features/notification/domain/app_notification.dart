import 'package:dart_mappable/dart_mappable.dart';

part 'app_notification.mapper.dart';

@MappableClass()
class AppNotification with AppNotificationMappable {
  final String path;
  final Map<String, dynamic>? data;

  AppNotification({
    required this.path,
    required this.data,
  });

  static const fromJson = AppNotificationMapper.fromJson;
}
