// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dart_mappable/dart_mappable.dart';

// part 'auth_credential.freezed.dart';
part 'auth_credential.mapper.dart';

// @freezed
@MappableClass()
class AuthCredential with AuthCredentialMappable {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
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
