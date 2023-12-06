import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';

@RoutePage()
class DemoCompScreen extends HookConsumerWidget {
  const DemoCompScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppScaffold(
      body: Center(
        child: Text('demo widget'),
      ),
    );
  }
}
