import 'package:flutter/material.dart';

import 'color_scheme.dart';

class DefaultERbColorScheme extends ERbColorScheme {
  const DefaultERbColorScheme.light()
      : super(
          success: const Color(0xff4caf50),
          info: const Color(0xff03a9f4),
          warning: const Color(0xffFF9D44),
          danger: const Color(0xffef5350),
          disable: const Color(0xff1D1B20),
          selectedColor: const Color(0xff0022B1),
          surfaceContainer: const Color(0xffFDFBF7),
        );

  const DefaultERbColorScheme.dark()
      : super(
          success: const Color(0xff1b5e20),
          info: const Color(0xff01579b),
          warning: const Color(0xffFF9D44),
          danger: const Color(0xffc62828),
          disable: const Color(0xffE6E0E9),
          selectedColor: const Color(0xff0022B1),
          surfaceContainer: const Color(0xffFDFBF7),
        );
}
