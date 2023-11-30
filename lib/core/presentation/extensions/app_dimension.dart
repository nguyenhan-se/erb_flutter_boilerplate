import 'package:flutter/material.dart';
import 'package:app_constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ScreenType {
  mobile,
  tablet,
  desktop,
  other,
}

class AppDimension {
  AppDimension._({
    required this.screenWidth,
    required this.screenHeight,
    required this.devicePixelRatio,
    required this.screenType,
  });

  static late AppDimension current;

  final double screenWidth;
  final double screenHeight;
  final double devicePixelRatio;
  final ScreenType screenType;

  static AppDimension of(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    final screen = AppDimension._(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      devicePixelRatio: devicePixelRatio,
      screenType: _getScreenType(screenWidth),
    );

    current = screen;

    return current;
  }

  double responsiveDimens({
    required double mobile,
    double? tablet,
    double? desktop,
    double? other,
  }) {
    switch (screenType) {
      case ScreenType.mobile:
        return mobile.dg;
      case ScreenType.tablet:
        return tablet?.dg ??
            ((mobile * AppSettings.maxMobileWidth) / AppSettings.wdp);
      case ScreenType.desktop:
        return tablet?.dg ??
            ((mobile * AppSettings.maxTabletWidth) / AppSettings.wdp);
      case ScreenType.other:
        return other?.dg ??
            ((mobile * AppSettings.maxDesktopWidth) / AppSettings.wdp);
    }
  }

  static ScreenType _getScreenType(double screenWidth) {
    if (screenWidth <= AppSettings.maxMobileWidth) {
      return ScreenType.mobile;
    } else if (screenWidth <= AppSettings.maxTabletWidth) {
      return ScreenType.tablet;
    } else if (screenWidth <= AppSettings.maxDesktopWidth) {
      return ScreenType.desktop;
    } else {
      return ScreenType.other;
    }
  }
}

extension ResponsiveDoubleExtension on double {
  double adaptive({
    double? tablet,
    double? desktop,
    double? other,
  }) {
    return AppDimension.current.responsiveDimens(
      mobile: this,
      tablet: tablet,
      desktop: desktop,
    );
  }
}

extension ResponsiveEdgeInsetsExtension on EdgeInsets {
  EdgeInsets adaptive({
    double? tablet,
    double? desktop,
    double? other,
  }) {
    return EdgeInsets.fromLTRB(
      AppDimension.current.responsiveDimens(
        mobile: left,
        tablet: tablet,
        desktop: desktop,
        other: other,
      ),
      AppDimension.current.responsiveDimens(
        mobile: top,
        tablet: tablet,
        desktop: desktop,
        other: other,
      ),
      AppDimension.current.responsiveDimens(
        mobile: right,
        tablet: tablet,
        desktop: desktop,
        other: other,
      ),
      AppDimension.current.responsiveDimens(
        mobile: bottom,
        tablet: tablet,
        desktop: desktop,
        other: other,
      ),
    );
  }

  EdgeInsets get flex {
    return EdgeInsets.fromLTRB(
      AppDimension.current.responsiveDimens(mobile: left),
      AppDimension.current.responsiveDimens(mobile: top),
      AppDimension.current.responsiveDimens(mobile: right),
      AppDimension.current.responsiveDimens(mobile: bottom),
    );
  }
}

extension ResponsiveSizeBoxExtension on SizedBox {
  SizedBox adaptive({
    double? tablet,
    double? desktop,
    double? other,
  }) {
    return SizedBox(
      height: AppDimension.current.responsiveDimens(
        mobile: height ?? 0,
        tablet: tablet,
        desktop: desktop,
        other: other,
      ),
      width: AppDimension.current.responsiveDimens(
        mobile: width ?? 0,
        tablet: tablet,
        desktop: desktop,
        other: other,
      ),
      key: key,
      child: child,
    );
  }

  SizedBox get flex {
    return SizedBox(
      height: AppDimension.current.responsiveDimens(mobile: height ?? 0),
      width: AppDimension.current.responsiveDimens(mobile: width ?? 0),
      key: key,
      child: child,
    );
  }
}
