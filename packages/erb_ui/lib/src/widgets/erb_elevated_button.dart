import 'package:erb_ui/theme.dart';
import 'package:flutter/material.dart';

import '_const/position.dart';

class ERbElevatedButton extends StatefulWidget {
  const ERbElevatedButton({
    this.onPressed,
    this.child,
    this.onLongPress,
    this.constraints,
    this.borderRadius,
    this.buttonColor,
    this.splashColor,
    this.shadowColor,
    this.enableGradient = false,
    this.gradient,
    this.elevation,
    this.label,
    this.position = ERbPosition.start,
    this.blockButton,
    this.fullWidthButton,
    this.icon,
    super.key,
  });

  final Widget? child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  final BoxConstraints? constraints;
  final BorderRadius? borderRadius;
  final Color? buttonColor;
  final Color? splashColor;
  final Color? shadowColor;
  final bool enableGradient;
  final Gradient? gradient;
  final double? elevation;

  /// label of type [String] is alternative to child. text will get priority over child
  final String? label;

  /// icon of type [Widget]
  final Widget? icon;

  /// icon type of [ERbPosition] i.e, start, end
  final ERbPosition position;

  /// on true state blockButton gives block size button
  final bool? blockButton;

  /// on true state full width Button gives full width button
  final bool? fullWidthButton;

  @override
  State<ERbElevatedButton> createState() => _ERbElevatedButtonState();
}

class _ERbElevatedButtonState extends State<ERbElevatedButton> {
  Widget? child;
  Widget? icon;
  Function? onPressed;
  late ERbPosition position;

  @override
  void initState() {
    child = widget.label != null ? Text(widget.label!) : widget.child;
    icon = widget.icon;
    onPressed = widget.onPressed;
    position = widget.position;

    super.initState();
  }

  @override
  void didUpdateWidget(ERbElevatedButton oldWidget) {
    child = widget.label != null ? Text(widget.label!) : widget.child;
    icon = widget.icon;
    onPressed = widget.onPressed;
    position = widget.position;
    super.didUpdateWidget(oldWidget);
  }

  BorderRadius get _borderRadius =>
      widget.borderRadius ?? BorderRadius.circular(24);

  Color? get _buttonColor =>
      widget.enableGradient ? Colors.transparent : widget.buttonColor;

  Color? get _buttonFColor => widget.enableGradient
      ? widget.splashColor ?? const Color(0xffffffff)
      : _buttonColor;

  double? buttonWidth() {
    double? buttonWidth = 0;
    if (widget.blockButton == true) {
      buttonWidth = MediaQuery.of(context).size.width * 0.88;
    } else if (widget.fullWidthButton == true) {
      buttonWidth = MediaQuery.of(context).size.width;
    } else {
      buttonWidth = null;
    }
    return buttonWidth;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final gradientColor =
        widget.gradient ?? theme.eRbColorScheme.primaryGradient;

    final padding = theme.elevatedButtonTheme.style!.padding!
        .resolve({MaterialState.pressed});

    final btnDisabled = widget.onPressed == null;

    return ElevatedButton(
      onPressed: widget.onPressed ?? widget.onPressed,
      onLongPress: widget.onLongPress,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: _borderRadius),
        backgroundColor: _buttonColor,
        foregroundColor: _buttonFColor,
        shadowColor: widget.shadowColor,
        elevation: widget.elevation,
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          gradient: widget.enableGradient && !btnDisabled ? gradientColor : null,
        ),
        child: Container(
          width: buttonWidth(),
          padding: padding,
          constraints: widget.constraints,
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: icon != null &&
                    child != null &&
                    (position == ERbPosition.start)
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[icon!, const SizedBox(width: 8), child!],
                  )
                : icon != null && child != null && (position == ERbPosition.end)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          child!,
                          const SizedBox(width: 8),
                          icon!
                        ],
                      )
                    : child,
          ),
        ),
      ),
    );
  }
}
