import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';

@RoutePage()
class SettingScreen extends HookConsumerWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(child: Text('setting screen')),
    );
  }
}
