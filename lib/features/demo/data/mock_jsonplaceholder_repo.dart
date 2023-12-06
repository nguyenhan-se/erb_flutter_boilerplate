import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/infrastructure/exceptions/exception.dart';

import 'mock_jsonplaceholder_api.dart';
import '../domain/demo_photo.dart';

part 'mock_jsonplaceholder_repo.g.dart';

@riverpod
MockJsonplaceholderRepo mockJsonplaceholderRepo(
    MockJsonplaceholderRepoRef ref) {
  return MockJsonplaceholderRepo(ref.watch(mockJsonplaceholderApiProvider));
}

class MockJsonplaceholderRepo with RepositoryExceptionMixin {
  MockJsonplaceholderRepo(this.api);

  final MockJsonplaceholderApi api;

  Future<List<DemoPhoto>> photos(Map<String, dynamic> page, DemoAlbum? album) {
    return runAsyncCatching(action: () async {
      return api.photos(<String, dynamic>{
        '_start': page['offset'],
        '_limit': page['size'],
        if (album != null) 'albumId': '${album.id}'
      });
    });
  }

  Future<DemoPhoto> photo(String id) async {
    return runAsyncCatching(action: () async {
      return api.photo(id);
    });
  }
}
