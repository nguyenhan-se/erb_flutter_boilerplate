import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/infrastructure/network/dio/dio_collection.dart';

import '../../domain/auth_credential.dart';

part 'auth_api.g.dart';

@riverpod
AuthApi authApi(AuthApiRef ref) {
  return AuthApi(ref.watch(dioProvider).mockDummyjson);
}

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST('/auth/login')
  Future<AuthCredential> login(@Body() SignInParams params);
}
