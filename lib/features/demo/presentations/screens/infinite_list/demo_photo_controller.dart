import 'package:erb_infinite_scroll/erb_infinite_scroll.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/mock_jsonplaceholder_repo.dart';
import '../../../domain/demo_photo.dart';

part 'demo_photo_controller.g.dart';

@riverpod
class DemoPhotoController extends _$DemoPhotoController
    with PagedMixin<int, DemoPhoto> {
  @override
  PagedState<int, DemoPhoto> build() {
    final repo = ref.watch(mockJsonplaceholderRepoProvider);

    return init(
      fetcher: PagedFetcher(
        load: (page, limit) async {
          final photos = await repo.photos({
            'offset': page * limit,
            'size': limit,
          }, null);

          return photos;
        },
        nextPageKeyBuilder: NextPageKeyBuilderDefault.mysqlPagination,
      ),
    );
  }
}
