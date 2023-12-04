import 'package:dart_mappable/dart_mappable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'auth_credential.mapper.dart';
part 'auth_credential.g.dart';

@MappableClass()
@HiveType(typeId: 2)
class AuthCredential with AuthCredentialMappable {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String firstName;
  @HiveField(3)
  final String lastName;
  @HiveField(4)
  final String gender;
  @HiveField(5)
  final String image;
  @HiveField(6)
  final String token;

  AuthCredential({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
  });

  static const fromJson = AuthCredentialMapper.fromJson;
}

@MappableClass()
class SignInParams with SignInParamsMappable {
  final String username;
  final String password;
  SignInParams({
    required this.username,
    required this.password,
  });

  static const fromJson = AuthCredentialMapper.fromJson;
}
