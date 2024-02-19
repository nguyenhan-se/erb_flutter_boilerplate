import 'package:flutter/material.dart';

class ERbButtonGradientStyle {
  Gradient? gradient;

  Color? textColor;

  Color? boderColor;

  BorderRadiusGeometry? radius;

  double? borderWidth;

  ERbButtonGradientStyle({
    this.gradient,
    this.textColor,
    this.radius,
    this.boderColor,
    this.borderWidth,
  });

  ERbButtonGradientStyle apply(ERbButtonGradientStyle? data) =>
      ERbButtonGradientStyle(
        radius: data?.radius ?? radius,
        gradient: data?.gradient ?? gradient,
        textColor: data?.textColor ?? textColor,
        boderColor: data?.boderColor ?? boderColor,
        borderWidth: data?.borderWidth ?? borderWidth,
      );
}
