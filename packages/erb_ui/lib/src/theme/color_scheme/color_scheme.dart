import 'package:flutter/material.dart';

extension ERbColorSchemeExtension on ThemeData {
  ERbColorScheme get customColorScheme => extension<ERbColorScheme>()!;
}

@immutable
class ERbColorScheme extends ThemeExtension<ERbColorScheme> {
  const ERbColorScheme({
    required this.success,
    required this.info,
    required this.warning,
    required this.danger,
    required this.disable,
    required this.selectedColor,
    required this.surfaceContainer,
  });

  final Color? success;
  final Color? info;
  final Color? warning;
  final Color? danger;
  final Color? disable;
  final Color? selectedColor;
  final Color? surfaceContainer;

  @override
  ERbColorScheme copyWith({
    Color? success,
    Color? info,
    Color? warning,
    Color? danger,
    Color? disable,
    Color? selectedColor,
    Color? surfaceContainer,
  }) {
    return ERbColorScheme(
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      disable: disable ?? this.disable,
      selectedColor: selectedColor ?? this.selectedColor,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
    );
  }

  // Controls how the properties change on theme changes
  @override
  ERbColorScheme lerp(ThemeExtension<ERbColorScheme>? other, double t) {
    if (other is! ERbColorScheme) {
      return this;
    }
    return ERbColorScheme(
      success: Color.lerp(success, other.success, t),
      info: Color.lerp(info, other.info, t),
      warning: Color.lerp(warning, other.warning, t),
      danger: Color.lerp(danger, other.danger, t),
      disable: Color.lerp(disable, other.disable, t),
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t),
      surfaceContainer: Color.lerp(surfaceContainer, other.surfaceContainer, t),
    );
  }
}
