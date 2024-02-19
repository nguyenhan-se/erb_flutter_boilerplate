import 'package:flutter/material.dart';

import 'erb_button_ink.dart';

enum ERbButtonSize { large, medium, small, extraSmall }

enum ERbButtonType { fill, outline, text }

enum ERbButtonShape { rectangle, round, square, circle, filled }

abstract class ERbButtonBase extends StatefulWidget {
  const ERbButtonBase({
    super.key,
    this.text,
    this.onTap,
    this.onLongPress,
    required this.disabled,
    this.textStyle,
    this.disableTextStyle,
    required this.size,
    required this.type,
    required this.shape,
    this.width,
    this.height,
    this.iconLeft,
    this.iconRight,
    this.child,
    this.padding,
  });

  final String? text;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final bool disabled;

  final TextStyle? textStyle;
  final TextStyle? disableTextStyle;

  final ERbButtonSize size;
  final ERbButtonType type;
  final ERbButtonShape shape;

  final double? width;
  final double? height;

  final Widget? iconLeft;
  final Widget? iconRight;
  final Widget? child;

  final EdgeInsetsGeometry? padding;
}

mixin ERbButtonBaseMixin<T extends ERbButtonBase> on State<T> {
  Widget display({
    BorderRadiusGeometry? borderRadius,
    Color? color,
    BoxBorder? border,
    Color? textColor,
    Gradient? gradient,
  }) =>
      Opacity(
        opacity: widget.disabled ? 0.5 : 1,
        child: ERbButtonInk(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          splashRadius: widget.shape == ERbButtonShape.circle
              ? BorderRadius.all(Radius.circular(_getHeight()))
              : borderRadius,
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.noScaling),
            child: Container(
              width: _getWidth(),
              height: _getHeight(),
              padding: _getPadding(),
              alignment: widget.shape == ERbButtonShape.filled
                  ? Alignment.center
                  : null,
              decoration: BoxDecoration(
                shape: widget.shape == ERbButtonShape.circle
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                borderRadius:
                    widget.shape == ERbButtonShape.circle ? null : borderRadius,
                gradient: gradient,
                color: color,
                border: border,
              ),
              child: widget.child ?? getChild(textColor: textColor),
            ),
          ),
        ),
      );

  Radius getRadius() {
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

  TextStyle getTextStyle() {
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

  Widget getChild({Color? textColor}) {
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
        style: getTextStyle().copyWith(color: textColor),
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
        height: getIconSize(),
        width: getIconSize(),
        child: icon,
      );

  double getIconSize() {
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
}
