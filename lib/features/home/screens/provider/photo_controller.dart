import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';

part 'photo_controller.g.dart';

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

class CustomExampleState extends PagedState<String, User> {
  // We can extends [PagedState] to add custom parameters to our state
  final bool filterByCity;

  const CustomExampleState({
    this.filterByCity = false,
    super.records,
    String? super.error,
    super.nextPageKey,
    List<String>? previousPageKeys,
  });

  // We can customize our .copyWith for example
  @override
  CustomExampleState copyWith({
    bool? filterByCity,
    List<User>? records,
    dynamic error,
    dynamic nextPageKey,
    List<String>? previousPageKeys,
  }) {
    final sup = super.copyWith(
        records: records,
        error: error,
        nextPageKey: nextPageKey,
        previousPageKeys: previousPageKeys);
    return CustomExampleState(
        filterByCity: filterByCity ?? this.filterByCity,
        records: sup.records,
        error: sup.error,
        nextPageKey: sup.nextPageKey,
        previousPageKeys: sup.previousPageKeys);
  }
}

@riverpod
class TodoController extends _$TodoController
    with PagedNotifierMixin<String, User, CustomExampleState> {
  @override
  FutureOr<CustomExampleState> build() async {
    // return AsyncData([User(id: '', name: '', profilePicture: '')]);
    return const CustomExampleState();
  }
  
  @override
  Future<List<User>?> load(String page, int limit) {
    // TODO: implement load
    throw UnimplementedError();
  }

  // @override
  // Future<List<User>?> load(page, int limit) async {
  //   state = const AsyncLoading();

  //   final currentState = await future;
  //   try {
  //     //as build can be called many times, ensure
  //     //we only hit our page API once per page
  //     if (currentState.previousPageKeys.contains(page)) {
  //       await Future.delayed(const Duration(seconds: 0), () {
  //         state = AsyncData(currentState.copyWith());
  //       });
  //       // return state.records;
  //       return currentState.records;
  //     }
  //     var users = await Future.delayed(const Duration(seconds: 1), () {
  //       // This simulates a network call to an api that returns paginated users
  //       return List.generate(
  //           20,
  //           (index) => User(
  //               id: "${page}_$index",
  //               name: "John",
  //               profilePicture: "https://via.placeholder.com/150/92c952"));
  //     });
  //     // we then update state accordingly
  //     state = AsyncData(currentState.copyWith(
  //         records: [...(currentState.records ?? []), ...users],
  //         nextPageKey: users.length < limit ? null : users[users.length - 1].id,
  //         previousPageKeys: {...currentState.previousPageKeys, page}.toList()));
  //   } catch (e) {
  //     state = AsyncData(currentState.copyWith(error: e.toString()));
  //   }

  //   return null;
  // }
}
