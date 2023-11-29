import 'package:dart_mappable/dart_mappable.dart';

import 'server_error_detail.dart';

part 'server_error.mapper.dart';

@MappableClass()
class ServerError with ServerErrorMappable {
  const ServerError({
    this.generalServerStatusCode,
    this.generalServerErrorType,
    this.generalServerErrorId,
    this.generalMessage,
    this.errors = const <ServerErrorDetail>[],
  });

  /// server-defined status code
  final String? generalServerStatusCode;

  /// server-defined error type
  final String? generalServerErrorType;

  /// server-defined error id
  final String? generalServerErrorId;

  /// server-defined message
  final String? generalMessage;
  final List<ServerErrorDetail> errors;
}
