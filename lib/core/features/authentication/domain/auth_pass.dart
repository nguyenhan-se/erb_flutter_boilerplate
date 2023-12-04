import 'package:dart_mappable/dart_mappable.dart';

part 'auth_pass.mapper.dart';

@MappableClass()
class AuthPass with AuthPassMappable {
  final String username;
  final String password;

  AuthPass({
    required this.username,
    required this.password,
  });

  static const fromJson = AuthPassMapper.fromJson;
}
