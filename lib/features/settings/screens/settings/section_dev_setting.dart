import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';

class SectionDevSetting extends ERbSettingsSection {
  const SectionDevSetting({super.key}) : super(tiles: const []);

  @override
  Widget build(BuildContext context) {
    return kDebugMode
        ? ERbSettingsSection(
            title: const Text('DEV'),
            tiles: <ERbSettingsTile>[
              ERbSettingsTile(
                leading: const Icon(Icons.manage_history_rounded),
                title: const Text('View Log'),
                onPressed: (context) {
                  AutoRouter.of(context).push(const TalkerRoute());
                },
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
