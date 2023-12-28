import 'package:erb_infinite_scroll/erb_infinite_scroll.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'demo_user_controller.dart';

part 'demo_user_filter_controller.g.dart';

@riverpod
class DemoUserFilterController extends _$DemoUserFilterController
    with PagedMixinFilter<User, String> {
  @override
  PagedState<User> build() {
    return init(
      fetcher: PagedFetcher(
        load: (page, limit) async {
          return await Future.delayed(
            const Duration(milliseconds: 500),
            () {
              // This simulates a network call to an api that returns paginated posts
              return List.generate(
                20,
                (index) => User(
                  id: "${page}_$index",
                  name: filter ?? '',
                  profilePicture: "https://via.placeholder.com/150/92c952",
                ),
              );
            },
          );
        },
      ),
    );
  }
}
