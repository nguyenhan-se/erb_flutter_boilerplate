import 'package:dart_mappable/dart_mappable.dart';

part 'server_error_detail.mapper.dart';

@MappableClass()
class ServerErrorDetail with ServerErrorDetailMappable {
  const ServerErrorDetail(
    this.detail,
    this.path,
    this.serverErrorId,
    this.serverStatusCode,
    this.message,
    this.field,
  );

  final String? detail;
  final String? path;

  /// server-defined error code
  final String? serverErrorId;

  /// server-defined status code
  final int? serverStatusCode;

  /// server-defined message
  final String? message;

  /// server-defined field
  final String? field;
}
