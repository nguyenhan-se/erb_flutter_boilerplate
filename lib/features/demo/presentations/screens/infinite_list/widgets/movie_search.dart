import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';
import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';

import '../demo_movie_controller.dart';
import '../../../../domain/demo_movie.dart';

class MovieSearch extends HookConsumerWidget {
  const MovieSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debounce = useDebounce(const Duration(milliseconds: 500));

    return ERbTextField(
      hintText: 'Search',
      onChanged: (text) {
        debounce(() {
          ref
              .read(demoMovieControllerProvider.notifier)
              .updateFilter(FilterMovieParams(query: text));
        });
      },
    );
  }
}
