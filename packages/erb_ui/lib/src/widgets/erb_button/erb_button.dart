import 'package:flutter/material.dart';

import 'erb_button_style.dart';

enum ErbButtonSize { large, medium, small, extraSmall }

enum ErbButtonType { fill, outline, text }

enum ErbButtonShape { rectangle, round, square, circle, filled }

enum ErbButtonTheme { primary, danger, light }

class ErbButton extends StatefulWidget {
  const ErbButton({
    super.key,
    this.text,
    this.onTap,
    this.onLongPress,
    this.textStyle,
    this.disableTextStyle,
    this.disabled = false,
    this.shape = ErbButtonShape.rectangle,
    this.size = ErbButtonSize.medium,
    this.theme = ErbButtonTheme.primary,
    this.type = ErbButtonType.fill,
    this.style,
    this.disableStyle,
    this.activeStyle,
    this.iconLeft,
    this.iconRight,
    this.child,
    this.padding,
    this.width,
    this.height,
  });

  final String? text;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final bool disabled;

  final TextStyle? textStyle;
  final TextStyle? disableTextStyle;

  final ErbButtonSize size;
  final ErbButtonType type;
  final ErbButtonTheme? theme;
  final ErbButtonShape shape;

  final ErbButtonStyle? style;
  final ErbButtonStyle? activeStyle;
  final ErbButtonStyle? disableStyle;

  final double? width;
  final double? height;

  final Widget? iconLeft;
  final Widget? iconRight;
  final Widget? child;

  final EdgeInsetsGeometry? padding;

  @override
  State<ErbButton> createState() => _ErbButtonState();
}

class _ErbButtonState extends State<ErbButton> {
  ErbButtonStyle get style {
    if (widget.disabled) {
      return _disableStyle;
    }
    return _activeStyle;
  }

  @override
  Widget build(BuildContext context) {
    Widget display = Container(
      width: _getWidth(),
      height: _getHeight(),
      padding: _getPadding(),
      alignment:
          widget.shape == ErbButtonShape.filled ? Alignment.center : null,
      decoration: BoxDecoration(
        shape: widget.shape == ErbButtonShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        borderRadius: widget.shape == ErbButtonShape.circle
            ? null
            : style.radius ?? BorderRadius.all(_getRadius()),
        color: widget.disabled ? style.backgroundColor : Colors.transparent,
        border: _getBorder(context),
      ),
      child: widget.child ?? _getChild(),
    );

    if (widget.disabled) {
      return display;
    }

    return Theme(
      data: Theme.of(context).copyWith(splashFactory: InkRipple.splashFactory),
      child: ClipRRect(
        borderRadius: widget.shape == ErbButtonShape.circle
            ? BorderRadius.all(
                Radius.circular(_getHeight()),
              )
            : style.radius ?? BorderRadius.all(_getRadius()),
        child: Material(
          color: style.backgroundColor,
          child: InkWell(
            onTap: () {},
            child: display,
          ),
        ),
      ),
    );
  }

  Radius _getRadius() {
    switch (widget.shape) {
      case ErbButtonShape.rectangle:
      case ErbButtonShape.square:
        return const Radius.circular(4);
      case ErbButtonShape.round:
      case ErbButtonShape.circle:
      case ErbButtonShape.filled:
        return const Radius.circular(24);
    }
  }

  TextStyle _getTextStyle() {
    if (widget.disabled && widget.disableTextStyle != null) {
      return widget.disableTextStyle!;
    }
    if (!widget.disabled && widget.textStyle != null) return widget.textStyle!;
    switch (widget.size) {
      case ErbButtonSize.large:
        return const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
      case ErbButtonSize.medium:
        return const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
      case ErbButtonSize.small:
        return const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
      case ErbButtonSize.extraSmall:
        return const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    }
  }

  Widget _getChild() {
    if (widget.text == null &&
        widget.iconLeft == null &&
        widget.iconRight == null) {
      return const SizedBox();
    }

    final children = <Widget>[];
    if (widget.iconLeft != null) {
      children.add(widget.iconLeft!);
    }
    if (widget.text != null) {
      var text = Text(
        widget.text!,
        style: _getTextStyle().copyWith(color: style.textColor),
      );
      children.add(text);
    }

    if (widget.iconRight != null) {
      children.add(widget.iconRight!);
    }

    if (children.length >= 2) {
      children.insert(
        1,
        const SizedBox(
          width: 8,
        ),
      );
    }
    if (children.length == 4) {
      children.insert(
        3,
        const SizedBox(
          width: 8,
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  double? _getWidth() {
    if (widget.width != null) {
      return widget.width;
    }
    if ((widget.shape == ErbButtonShape.square ||
        widget.shape == ErbButtonShape.circle)) {
      switch (widget.size) {
        case ErbButtonSize.large:
          return 48;
        case ErbButtonSize.medium:
          return 40;
        case ErbButtonSize.small:
          return 32;
        case ErbButtonSize.extraSmall:
          return 28;
      }
    }
    return null;
  }

  double _getHeight() {
    if (widget.height != null) {
      return widget.height!;
    }
    switch (widget.size) {
      case ErbButtonSize.large:
        return 48;
      case ErbButtonSize.medium:
        return 40;
      case ErbButtonSize.small:
        return 32;
      case ErbButtonSize.extraSmall:
        return 28;
    }
  }

  EdgeInsetsGeometry? _getPadding() {
    if (widget.padding != null) {
      return widget.padding;
    }
    var equalSide = widget.shape == ErbButtonShape.square ||
        widget.shape == ErbButtonShape.circle;

    double horizontalPadding;

    switch (widget.size) {
      case ErbButtonSize.large:
        horizontalPadding = equalSide ? 12 : 20;

        break;
      case ErbButtonSize.medium:
        horizontalPadding = equalSide ? 10 : 16;

        break;
      case ErbButtonSize.small:
        horizontalPadding = equalSide ? 7 : 12;

        break;
      case ErbButtonSize.extraSmall:
        horizontalPadding = equalSide ? 5 : 8;

        break;
    }

    return EdgeInsets.only(
      left: horizontalPadding,
      right: horizontalPadding,
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

  ErbButtonStyle _generateInnerStyle() {
    switch (widget.type) {
      case ErbButtonType.fill:
        return ErbButtonStyle.generateFillStyleByTheme(
            context, widget.theme, widget.disabled);
      case ErbButtonType.outline:
        return ErbButtonStyle.generateOutlineStyleByTheme(
            context, widget.theme, widget.disabled);
      case ErbButtonType.text:
        return ErbButtonStyle.generateTextStyleByTheme(
            context, widget.theme, widget.disabled);
    }
  }

  ErbButtonStyle get _activeStyle {
    return _generateInnerStyle().apply(widget.activeStyle ?? widget.style);
  }

  ErbButtonStyle get _disableStyle {
    return _generateInnerStyle().apply(widget.disableStyle ?? widget.style);
  }
}
