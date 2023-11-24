import 'package:flutter/material.dart';

extension ERbRadiusSchemeExtension on ThemeData {
  ERbRadiusScheme get eRbRadiusScheme => extension<ERbRadiusScheme>()!;
}

@immutable
class ERbRadiusScheme extends ThemeExtension<ERbRadiusScheme> {
  const ERbRadiusScheme({
    required this.tiny,
    required this.small,
    required this.medium,
    required this.large,
    required this.huge,
  });

  const ERbRadiusScheme.fallback()
      : tiny = const Radius.circular(2),
        small = const Radius.circular(4),
        medium = const Radius.circular(8),
        large = const Radius.circular(12),
        huge = const Radius.circular(16);

  final Radius tiny;
  final Radius small;
  final Radius medium;
  final Radius large;
  final Radius huge;

  @override
  ERbRadiusScheme copyWith({
    Radius? tiny,
    Radius? small,
    Radius? medium,
    Radius? large,
    Radius? huge,
  }) {
    return ERbRadiusScheme(
      tiny: tiny ?? this.tiny,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      huge: huge ?? this.huge,
    );
  }

  @override
  ThemeExtension<ERbRadiusScheme> lerp(
    covariant ERbRadiusScheme? other,
    double t,
  ) {
    return ERbRadiusScheme(
      tiny: Radius.lerp(tiny, other?.tiny ?? tiny, t)!,
      small: Radius.lerp(small, other?.small ?? small, t)!,
      medium: Radius.lerp(medium, other?.medium ?? medium, t)!,
      large: Radius.lerp(large, other?.large ?? large, t)!,
      huge: Radius.lerp(huge, other?.huge ?? huge, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ERbRadiusScheme &&
        other.tiny == tiny &&
        other.small == small &&
        other.medium == medium &&
        other.large == large &&
        other.huge == huge;
  }

  @override
  int get hashCode {
    return tiny.hashCode ^
        small.hashCode ^
        medium.hashCode ^
        large.hashCode ^
        huge.hashCode;
  }
}
