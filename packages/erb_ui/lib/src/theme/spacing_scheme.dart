import 'dart:ui';

import 'package:flutter/material.dart';

extension ERbSpacingSchemeExtension on ThemeData {
  ERbSpacingScheme get eRbSpacingScheme => extension<ERbSpacingScheme>()!;
}

@immutable
class ERbSpacingScheme extends ThemeExtension<ERbSpacingScheme> {
  const ERbSpacingScheme({
    required this.xxs,
    required this.xs,
    required this.s,
    required this.m,
    required this.l,
    required this.xl,
    required this.xxl,
  });

  const ERbSpacingScheme.fallback()
      : xxs = 2,
        xs = 4,
        s = 6,
        m = 8,
        l = 12,
        xl = 16,
        xxl = 24;

  final double xxs;
  final double xs;
  final double s;
  final double m;
  final double l;
  final double xl;
  final double xxl;

  @override
  ERbSpacingScheme copyWith({
    double? xxs,
    double? xs,
    double? s,
    double? m,
    double? l,
    double? xl,
    double? xxl,
  }) {
    return ERbSpacingScheme(
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      s: s ?? this.s,
      m: m ?? this.m,
      l: l ?? this.l,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  ThemeExtension<ERbSpacingScheme> lerp(
    covariant ERbSpacingScheme? other,
    double t,
  ) {
    return ERbSpacingScheme(
      xxs: lerpDouble(xxs, other?.xxs ?? xxs, t)!,
      xs: lerpDouble(xs, other?.xs ?? xs, t)!,
      s: lerpDouble(s, other?.s ?? s, t)!,
      m: lerpDouble(m, other?.m ?? m, t)!,
      l: lerpDouble(l, other?.l ?? l, t)!,
      xl: lerpDouble(xl, other?.xl ?? xl, t)!,
      xxl: lerpDouble(xxl, other?.xxl ?? xxl, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ERbSpacingScheme &&
        other.xxs == xxs &&
        other.xs == xs &&
        other.s == s &&
        other.m == m &&
        other.l == l &&
        other.xl == xl &&
        other.xxl == xxl;
  }

  @override
  int get hashCode {
    return xxs.hashCode ^
        xs.hashCode ^
        s.hashCode ^
        m.hashCode ^
        l.hashCode ^
        xl.hashCode ^
        xxl.hashCode;
  }
}
