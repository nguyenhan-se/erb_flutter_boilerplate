import 'package:erb_ui/theme.dart';
import 'package:flutter/material.dart';

import '../const/enum.dart';
import 'erb_gradient_style.dart';
import 'gradient_box_border.dart';
import '../base/erb_button_base.dart';

class ERbGradientButton extends ERbButtonBase {
  const ERbGradientButton({
    super.key,
    super.text,
    super.onTap,
    super.onLongPress,
    super.textStyle,
    super.disableTextStyle,
    super.disabled = false,
    super.shape = ERbButtonShape.rectangle,
    super.size = ERbButtonSize.medium,
    super.type = ERbButtonType.fill,
    this.style,
    this.disableStyle,
    this.activeStyle,
    super.iconLeft,
    super.iconRight,
    super.child,
    super.padding,
    super.width,
    super.height,
  });

  final ERbButtonGradientStyle? style;
  final ERbButtonGradientStyle? activeStyle;
  final ERbButtonGradientStyle? disableStyle;

  @override
  State<ERbGradientButton> createState() => _ERbButtonState();
}

class _ERbButtonState extends State<ERbGradientButton> with ERbButtonBaseMixin {
  ERbButtonGradientStyle get style {
    if (widget.disabled) {
      return _disableStyle;
    }
    return _activeStyle;
  }

  @override
  Widget build(BuildContext context) {
    return display(
      borderRadius: style.radius ?? BorderRadius.all(getRadius()),
      gradient: widget.type == ERbButtonType.outline ? null : style.gradient,
      border: _getBorder(context),
      textColor: style.textColor,
    );
  }

  BoxBorder? _getBorder(BuildContext context) {
    if (widget.type == ERbButtonType.outline && style.gradient != null) {
      return GradientBoxBorder(
        gradient: style.gradient!,
        width: style.borderWidth ?? 1,
      );
    }
    if (style.boderColor != null) {
      return Border.all(
        color: style.boderColor ?? Colors.transparent,
        width: style.borderWidth ?? 1,
      );
    }
    return null;
  }

  ERbButtonGradientStyle get _activeStyle {
    return erbGradientStyle.apply(widget.activeStyle ?? widget.style);
  }

  ERbButtonGradientStyle get _disableStyle {
    return erbGradientStyle.apply(widget.disableStyle ?? widget.style);
  }

  ERbButtonGradientStyle get erbGradientStyle => ERbButtonGradientStyle(
        gradient: Theme.of(context).eRbColorScheme.primaryGradient,
        textColor: widget.type == ERbButtonType.outline
            ? Theme.of(context).colorScheme.primary
            : Colors.white,
      );
}
