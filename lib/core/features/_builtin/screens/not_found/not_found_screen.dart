import 'package:flutter/material.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';

@RoutePage()
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 28,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'context.t.exception.screen_not_found',
                    textAlign: TextAlign.center,
                  ),
                  // KSizedBox.h32.size,
                  FilledButton(
                    onPressed: () {
                      AutoRouter.of(context).replace(const HomeRoute());
                    },
                    child: const Text(
                      'context.t.system.go_to_home',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
