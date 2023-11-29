import 'dart:math';

import 'package:flutter/material.dart';

const errorFaces = [
  '(･o･;)',
  'Σ(ಠ_ಠ)',
  'ಥ_ಥ',
  '(˘･_･˘)',
  '(；￣Д￣)',
  '(･Д･。',
];

class ERbOopsError extends StatelessWidget {
  ERbOopsError({
    super.key,
    this.text,
    this.button,
    this.iconData,
  }) {
    errorFace = errorFaces.elementAt(Random().nextInt(errorFaces.length));
  }

  final String? text;
  final IconData? iconData;
  final Widget? button;

  late final String errorFace;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconData != null
                ? Icon(
                    iconData,
                  )
                : Text(
                    errorFace,
                    textAlign: TextAlign.center,
                    style: textTheme.displayMedium,
                  ),
            const SizedBox(height: 16),
            if (text != null)
              Text(
                text!,
                textAlign: TextAlign.center,
                style: textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            if (button != null) button!,
          ],
        ),
      ),
    );
  }
}
