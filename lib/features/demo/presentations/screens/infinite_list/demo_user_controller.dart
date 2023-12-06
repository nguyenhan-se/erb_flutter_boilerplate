import 'package:erb_infinite_scroll/erb_infinite_scroll.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'demo_user_controller.g.dart';

class User {
  final String id;
  final String name;
  final String profilePicture;
  const User({
    required this.id,
    required this.name,
    required this.profilePicture,
  });
}

@riverpod
class DemoUserController extends _$DemoUserController with PagedMixin<int, User> {
  @override
  PagedState<int, User> build() {
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
                  name: "John",
                  profilePicture: "https://via.placeholder.com/150/92c952",
                ),
              );
            },
          );
        },
        nextPageKeyBuilder: NextPageKeyBuilderDefault.mysqlPagination,
      ),
    );
  }
}
