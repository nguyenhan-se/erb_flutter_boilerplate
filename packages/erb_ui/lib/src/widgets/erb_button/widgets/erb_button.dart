import 'package:flutter/material.dart';

import 'erb_button_style.dart';
import '../const/enum.dart';
import '../base/erb_button_base.dart';

class ERbButton extends ERbButtonBase {
  const ERbButton({
    super.key,
    super.text,
    super.onTap,
    super.onLongPress,
    super.textStyle,
    super.disableTextStyle,
    super.disabled = false,
    super.shape = ERbButtonShape.rectangle,
    super.size = ERbButtonSize.medium,
    this.theme = ERbButtonTheme.primary,
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

  final ERbButtonTheme? theme;

  final ERbButtonStyle? style;
  final ERbButtonStyle? activeStyle;
  final ERbButtonStyle? disableStyle;

  @override
  State<ERbButton> createState() => _ERbButtonState();
}

class _ERbButtonState extends State<ERbButton> with ERbButtonBaseMixin {
  ERbButtonStyle get style {
    if (widget.disabled) {
      return _disableStyle;
    }
    return _activeStyle;
  }

  @override
  Widget build(BuildContext context) {
    return display(
      borderRadius: style.radius ?? BorderRadius.all(getRadius()),
      color: style.backgroundColor,
      border: _getBorder(context),
      textColor: style.textColor,
    );
  }

  Border? _getBorder(BuildContext context) {
    if (style.boderColor != null) {
      return Border.all(
        color: style.boderColor ?? Colors.transparent,
        width: style.borderWidth ?? 1,
      );
    }
    return null;
  }

  ERbButtonStyle _generateInnerStyle() {
    switch (widget.type) {
      case ERbButtonType.fill:
        return ERbButtonStyle.generateFillStyleByTheme(
            context, widget.theme, widget.disabled);
      case ERbButtonType.outline:
        return ERbButtonStyle.generateOutlineStyleByTheme(
            context, widget.theme, widget.disabled);
      case ERbButtonType.text:
        return ERbButtonStyle.generateTextStyleByTheme(
            context, widget.theme, widget.disabled);
    }
  }

  ERbButtonStyle get _activeStyle {
    return _generateInnerStyle().apply(widget.activeStyle ?? widget.style);
  }

  ERbButtonStyle get _disableStyle {
    return _generateInnerStyle().apply(widget.disableStyle ?? widget.style);
  }
}
