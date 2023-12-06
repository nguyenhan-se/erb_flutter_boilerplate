import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/infrastructure/network/dio/dio_collection.dart';

import '../domain/demo_photo.dart';

part 'mock_jsonplaceholder_api.g.dart';

@riverpod
MockJsonplaceholderApi mockJsonplaceholderApi(MockJsonplaceholderApiRef ref) {
  return MockJsonplaceholderApi(ref.watch(dioProvider).mockJsonplaceholder);
}

@RestApi()
abstract class MockJsonplaceholderApi {
  factory MockJsonplaceholderApi(Dio dio) = _MockJsonplaceholderApi;

  @GET('/photos')
  Future<List<DemoPhoto>> photos(@Queries() Map<String, dynamic> queries);

  @GET('/photos/{id}')
  Future<DemoPhoto> photo(@Path('id') String id);
}
