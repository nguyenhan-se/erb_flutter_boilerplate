import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';

class ErbButtonStyle {
  Color? backgroundColor;

  Color? textColor;

  Color? boderColor;

  BorderRadiusGeometry? radius;

  double? borderWidth;

  ErbButtonStyle({
    this.backgroundColor,
    this.textColor,
    this.radius,
    this.boderColor,
    this.borderWidth,
  });

  ErbButtonStyle.generateFillStyleByTheme(
      BuildContext context, ErbButtonTheme? theme, bool disabled) {
    switch (theme) {
      case ErbButtonTheme.primary:
        textColor = Theme.of(context).colorScheme.onPrimary;
        backgroundColor = Theme.of(context).colorScheme.primary;
        break;
      case ErbButtonTheme.danger:
        textColor = Theme.of(context).colorScheme.onError;
        backgroundColor = Theme.of(context).colorScheme.error;
        break;
      case ErbButtonTheme.light:
        textColor = Theme.of(context).colorScheme.onPrimaryContainer;
        backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        break;

      case null:
    }
    _disabledColor(disabled);
  }

  ErbButtonStyle.generateOutlineStyleByTheme(
      BuildContext context, ErbButtonTheme? theme, bool disabled) {
    final themeData = Theme.of(context);

    switch (theme) {
      case ErbButtonTheme.primary:
        textColor = themeData.colorScheme.primary;
        backgroundColor = themeData.colorScheme.surface;
        boderColor = themeData.colorScheme.primary;
        break;
      case ErbButtonTheme.danger:
        textColor = themeData.colorScheme.error;
        backgroundColor = themeData.colorScheme.tertiaryContainer;
        boderColor = themeData.colorScheme.error;
        break;
      case ErbButtonTheme.light:
        textColor = themeData.colorScheme.primary;
        backgroundColor = themeData.colorScheme.primary.withOpacity(0.05);
        boderColor = themeData.colorScheme.primary;
        break;
      case null:
    }
    _disabledColor(disabled);
  }

  ErbButtonStyle.generateTextStyleByTheme(
      BuildContext context, ErbButtonTheme? theme, bool disabled) {
    final themeData = Theme.of(context);

    switch (theme) {
      case ErbButtonTheme.primary:
        textColor = themeData.colorScheme.primary;
        backgroundColor = Colors.transparent;
        break;
      case ErbButtonTheme.danger:
        textColor = themeData.colorScheme.error;
        backgroundColor = Colors.transparent;
        break;
      case ErbButtonTheme.light:
        textColor = themeData.colorScheme.primary;
        backgroundColor = Colors.transparent;
        break;
      case null:
    }
    _disabledColor(disabled);
  }

  void _disabledColor(bool disabled) {
    if (disabled) {
      const opacity = 0.5;
      textColor = textColor?.withOpacity(opacity);
      backgroundColor = backgroundColor?.withOpacity(opacity);
      boderColor = boderColor?.withOpacity(opacity);
    }
  }

  ErbButtonStyle apply(ErbButtonStyle? data) => ErbButtonStyle(
        radius: data?.radius ?? radius,
        backgroundColor: data?.backgroundColor ?? backgroundColor,
        textColor: data?.textColor ?? textColor,
        boderColor: data?.boderColor ?? boderColor,
        borderWidth: data?.borderWidth ?? borderWidth,
      );
}
