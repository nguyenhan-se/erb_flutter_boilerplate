import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart' as talker;

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/presentation/providers/talker_log/talker_provider.dart';

@RoutePage()
class TalkerScreen extends ConsumerWidget {
  const TalkerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => talker.TalkerScreen(
        talker: ref.watch(talkerProvider),
      );
}
