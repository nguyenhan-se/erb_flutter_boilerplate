import 'package:flutter/material.dart';

class ERbButtonInk extends StatelessWidget {
  const ERbButtonInk({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.splashRadius,
  });

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final BorderRadiusGeometry? splashRadius;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashFactory: InkRipple.splashFactory),
      child: ClipRRect(
        borderRadius: splashRadius ?? BorderRadius.zero,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            child,
            onTap != null || onLongPress != null
                ? Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onTap,
                        onLongPress: onLongPress,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
