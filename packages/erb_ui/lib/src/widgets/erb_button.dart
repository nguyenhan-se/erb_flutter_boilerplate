import 'package:erb_ui/theme.dart';
import 'package:flutter/material.dart';

class ERbButton extends StatelessWidget {
  const ERbButton({
    required this.onPressed,
    required this.child,
    this.onLongPress,
    this.padding = const EdgeInsets.symmetric(
      vertical: 14,
      horizontal: 80,
    ),
    this.constraints,
    this.borderRadius,
    this.buttonColor,
    this.splashColor,
    this.shadowColor,
    this.enableGradient = false,
    this.gradient,
    this.elevation = 0,
    super.key,
  });

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BoxConstraints? constraints;
  final BorderRadius? borderRadius;
  final Color? buttonColor;
  final Color? splashColor;
  final Color? shadowColor;
  final bool enableGradient;
  final Gradient? gradient;
  final double elevation;

  BorderRadius get _borderRadius => borderRadius ?? BorderRadius.circular(24);

  Color? get _buttonColor => enableGradient ? Colors.transparent : buttonColor;
  Color? get _buttonFColor =>
      enableGradient ? splashColor ?? const Color(0xffffffff) : _buttonColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final gradientColor = gradient ?? theme.eRbColorScheme.primaryGradient;

    return ElevatedButton(
      key: key,
      onPressed: onPressed ?? onPressed,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: _borderRadius),
        backgroundColor: _buttonColor,
        foregroundColor: _buttonFColor,
        shadowColor: shadowColor,
        elevation: elevation,
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          gradient: enableGradient ? gradientColor : null,
        ),
        child: Container(
          padding: padding,
          constraints: constraints,
          child: child,
        ),
      ),
    );
  }
}
