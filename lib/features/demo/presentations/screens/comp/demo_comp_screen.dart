import 'package:flutter/material.dart';
import 'package:app_constants/app_constants.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';

import 'tab_comp_list.dart';

@RoutePage()
class DemoCompScreen extends HookConsumerWidget {
  const DemoCompScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: listCompTab.length);
    return AppScaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            labelPadding: KEdgeInsets.ob12.size,
            tabs: listCompTab.map((item) => Text(item.title)).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: listCompTab
                  .map((item) => Padding(
                        padding: KEdgeInsets.a12.size,
                        child: item.child,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
