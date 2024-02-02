import 'package:flutter/material.dart';

import 'erb_button_style.dart';

enum ERbButtonSize { large, medium, small, extraSmall }

enum ERbButtonType { fill, outline, text }

enum ERbButtonShape { rectangle, round, square, circle, filled }

enum ERbButtonTheme { defaultTheme, primary, danger, light }

class ERbButton extends StatefulWidget {
  const ERbButton({
    super.key,
    this.text,
    this.onTap,
    this.onLongPress,
    this.textStyle,
    this.disableTextStyle,
    this.disabled = false,
    this.shape = ERbButtonShape.rectangle,
    this.size = ERbButtonSize.medium,
    this.theme = ERbButtonTheme.primary,
    this.type = ERbButtonType.fill,
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

  final ERbButtonSize size;
  final ERbButtonType type;
  final ERbButtonTheme? theme;
  final ERbButtonShape shape;

  final ERbButtonStyle? style;
  final ERbButtonStyle? activeStyle;
  final ERbButtonStyle? disableStyle;

  final double? width;
  final double? height;

  final Widget? iconLeft;
  final Widget? iconRight;
  final Widget? child;

  final EdgeInsetsGeometry? padding;

  @override
  State<ERbButton> createState() => _ERbButtonState();
}

class _ERbButtonState extends State<ERbButton> {
  ERbButtonStyle get style {
    if (widget.disabled) {
      return _disableStyle;
    }
    return _activeStyle;
  }

  @override
  Widget build(BuildContext context) {
    Widget display = MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: Container(
        width: _getWidth(),
        height: _getHeight(),
        padding: _getPadding(),
        alignment:
            widget.shape == ERbButtonShape.filled ? Alignment.center : null,
        decoration: BoxDecoration(
          shape: widget.shape == ERbButtonShape.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
          borderRadius: widget.shape == ERbButtonShape.circle
              ? null
              : style.radius ?? BorderRadius.all(_getRadius()),
          color: widget.disabled ? style.backgroundColor : Colors.transparent,
          border: _getBorder(context),
        ),
        child: widget.child ?? _getChild(),
      ),
    );

    if (widget.disabled) {
      return Opacity(opacity: 0.5, child: display);
    }

    return Theme(
      data: Theme.of(context).copyWith(splashFactory: InkRipple.splashFactory),
      child: ClipRRect(
        borderRadius: widget.shape == ERbButtonShape.circle
            ? BorderRadius.all(
                Radius.circular(_getHeight()),
              )
            : style.radius ?? BorderRadius.all(_getRadius()),
        child: Material(
          color: style.backgroundColor,
          child: InkWell(
            onTap: widget.onTap,
            onLongPress: widget.onLongPress,
            child: display,
          ),
        ),
      ),
    );
  }

  Radius _getRadius() {
    switch (widget.shape) {
      case ERbButtonShape.rectangle:
      case ERbButtonShape.square:
        return const Radius.circular(4);
      case ERbButtonShape.round:
      case ERbButtonShape.circle:
      case ERbButtonShape.filled:
        return const Radius.circular(24);
    }
  }

  TextStyle _getTextStyle() {
    if (widget.disabled && widget.disableTextStyle != null) {
      return widget.disableTextStyle!;
    }
    if (!widget.disabled && widget.textStyle != null) return widget.textStyle!;
    switch (widget.size) {
      case ERbButtonSize.large:
        return const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
      case ERbButtonSize.medium:
        return const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
      case ERbButtonSize.small:
        return const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
      case ERbButtonSize.extraSmall:
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
      children.add(_icon(widget.iconLeft!));
    }
    if (widget.text != null) {
      var text = Text(
        widget.text!,
        style: _getTextStyle().copyWith(color: style.textColor),
      );
      children.add(text);
    }

    if (widget.iconRight != null) {
      children.add(_icon(widget.iconRight!));
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
    if ((widget.shape == ERbButtonShape.square ||
        widget.shape == ERbButtonShape.circle)) {
      switch (widget.size) {
        case ERbButtonSize.large:
          return 48;
        case ERbButtonSize.medium:
          return 40;
        case ERbButtonSize.small:
          return 32;
        case ERbButtonSize.extraSmall:
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
      case ERbButtonSize.large:
        return 48;
      case ERbButtonSize.medium:
        return 40;
      case ERbButtonSize.small:
        return 32;
      case ERbButtonSize.extraSmall:
        return 28;
    }
  }

  Widget _icon(Widget icon) => SizedBox(
        height: _getIconSize(),
        width: _getIconSize(),
        child: icon,
      );

  double _getIconSize() {
    switch (widget.size) {
      case ERbButtonSize.large:
        return 24;
      case ERbButtonSize.medium:
        return 22;
      case ERbButtonSize.small:
        return 20;
      case ERbButtonSize.extraSmall:
        return 20;
    }
  }

  EdgeInsetsGeometry? _getPadding() {
    if (widget.padding != null) {
      return widget.padding;
    }
    var equalSide = widget.shape == ERbButtonShape.square ||
        widget.shape == ERbButtonShape.circle;

    double horizontalPadding;

    switch (widget.size) {
      case ERbButtonSize.large:
        horizontalPadding = equalSide ? 12 : 20;

        break;
      case ERbButtonSize.medium:
        horizontalPadding = equalSide ? 10 : 16;

        break;
      case ERbButtonSize.small:
        horizontalPadding = equalSide ? 7 : 12;

        break;
      case ERbButtonSize.extraSmall:
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
