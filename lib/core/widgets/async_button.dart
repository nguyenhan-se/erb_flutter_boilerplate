import 'package:erb_ui/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';

class AsyncButton extends HookWidget {
  const AsyncButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.enabled = true,
  });
  final AsyncCallback onPressed;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final (clear: _, :mutate, :snapshot) = useSideEffect<void>();
    Future<void> pressButton() async {
      final future = onPressed();
      mutate(future);
      try {
        await future;
      } catch (exception) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong $exception')),
        );
      }
    }

    // ignore: deprecated_member_use
    return ERbElevatedButton(
      onPressed: enabled
          ? switch (snapshot) {
              AsyncSnapshot(connectionState: ConnectionState.waiting) => null,
              _ => pressButton,
            }
          : null,
      enableGradient: true,
      position: ERbPosition.end,
      icon: switch (snapshot) {
        AsyncSnapshot(connectionState: ConnectionState.waiting) =>
          const SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
            ),
          ),
        _ => null,
      },
      label: label,
    );
  }
}
