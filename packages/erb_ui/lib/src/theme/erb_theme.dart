import 'package:erb_ui/src/theme/color_scheme/default_color_scheme.dart';
import 'package:flutter/material.dart';

import 'color_scheme/color_scheme.dart';
import 'radius_scheme.dart';
import 'spacing_scheme.dart';

class ERbTheme {
  final ERbSpacingScheme spacingScheme;
  final ERbRadiusScheme radiusScheme;
  final ERbColorScheme eRbColorScheme;

  late final ThemeData data;

  ERbTheme({
    required ColorScheme colorScheme,
    this.spacingScheme = const ERbSpacingScheme.fallback(),
    this.radiusScheme = const ERbRadiusScheme.fallback(),
    this.eRbColorScheme = const DefaultERbColorScheme.light(),
  }) {
    data = ThemeData.from(colorScheme: colorScheme);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ERbTheme &&
        other.spacingScheme == spacingScheme &&
        other.radiusScheme == radiusScheme &&
        other.data == data;
  }

  @override
  int get hashCode {
    return spacingScheme.hashCode ^ radiusScheme.hashCode ^ data.hashCode;
  }
}
