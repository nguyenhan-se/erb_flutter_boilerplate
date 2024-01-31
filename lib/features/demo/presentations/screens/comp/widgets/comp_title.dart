import 'package:erb_shared/extensions.dart';
import 'package:flutter/material.dart';

class CompTitle extends StatelessWidget {
  const CompTitle({
    required this.title,
    required this.child,
    super.key,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        child
      ],
    );
  }
}
