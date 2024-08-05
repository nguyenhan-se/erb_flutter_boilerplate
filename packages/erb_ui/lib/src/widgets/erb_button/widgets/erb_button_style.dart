import 'package:flutter/material.dart';

import '../const/enum.dart';

class ERbButtonStyle {
  Color? backgroundColor;

  Color? textColor;

  Color? boderColor;

  BorderRadiusGeometry? radius;

  double? borderWidth;

  ERbButtonStyle({
    this.backgroundColor,
    this.textColor,
    this.radius,
    this.boderColor,
    this.borderWidth,
  });

  ERbButtonStyle.generateFillStyleByTheme(
      BuildContext context, ERbButtonTheme? theme, bool disabled) {
    switch (theme) {
      case ERbButtonTheme.primary:
        textColor = Theme.of(context).colorScheme.onPrimary;
        backgroundColor = Theme.of(context).colorScheme.primary;
        break;
      case ERbButtonTheme.danger:
        textColor = Theme.of(context).colorScheme.onError;
        backgroundColor = Theme.of(context).colorScheme.error;
        break;
      case ERbButtonTheme.light:
        textColor = Theme.of(context).colorScheme.onPrimaryContainer;
        backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        break;
      case ERbButtonTheme.defaultTheme:
        backgroundColor = Theme.of(context).colorScheme.surfaceContainerHighest;
        textColor = Theme.of(context).colorScheme.onSurfaceVariant;
        break;

      case null:
    }
  }

  ERbButtonStyle.generateOutlineStyleByTheme(
      BuildContext context, ERbButtonTheme? theme, bool disabled) {
    final themeData = Theme.of(context);

    switch (theme) {
      case ERbButtonTheme.primary:
        textColor = themeData.colorScheme.primary;
        backgroundColor = themeData.colorScheme.surface;
        boderColor = themeData.colorScheme.primary;
        break;
      case ERbButtonTheme.danger:
        textColor = themeData.colorScheme.error;
        backgroundColor = themeData.colorScheme.tertiaryContainer;
        boderColor = themeData.colorScheme.error;
        break;
      case ERbButtonTheme.light:
        textColor = themeData.colorScheme.primary;
        backgroundColor = themeData.colorScheme.primary.withOpacity(0.05);
        boderColor = themeData.colorScheme.primary;
        break;
      case ERbButtonTheme.defaultTheme:
        backgroundColor = themeData.colorScheme.surface;
        textColor = themeData.colorScheme.onSurface;
        boderColor = themeData.colorScheme.outline;

      case null:
    }
  }

  ERbButtonStyle.generateTextStyleByTheme(
      BuildContext context, ERbButtonTheme? theme, bool disabled) {
    final themeData = Theme.of(context);

    switch (theme) {
      case ERbButtonTheme.primary:
        textColor = themeData.colorScheme.primary;
        backgroundColor = Colors.transparent;
        break;
      case ERbButtonTheme.danger:
        textColor = themeData.colorScheme.error;
        backgroundColor = Colors.transparent;
        break;
      case ERbButtonTheme.light:
        textColor = themeData.colorScheme.primary;
        backgroundColor = Colors.transparent;
        break;
      case ERbButtonTheme.defaultTheme:
        backgroundColor = Colors.transparent;
        textColor = themeData.colorScheme.onSurfaceVariant;
      case null:
    }
  }

  ERbButtonStyle apply(ERbButtonStyle? data) => ERbButtonStyle(
        radius: data?.radius ?? radius,
        backgroundColor: data?.backgroundColor ?? backgroundColor,
        textColor: data?.textColor ?? textColor,
        boderColor: data?.boderColor ?? boderColor,
        borderWidth: data?.borderWidth ?? borderWidth,
      );

  ERbButtonStyle copyWith({
    Color? backgroundColor,
    Color? textColor,
    BorderRadiusGeometry? radius,
    Color? boderColor,
    double? borderWidth,
  }) =>
      ERbButtonStyle(
        radius: radius ?? this.radius,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textColor: textColor ?? this.textColor,
        boderColor: boderColor ?? this.boderColor,
        borderWidth: borderWidth ?? this.borderWidth,
      );
}
