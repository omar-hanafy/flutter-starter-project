import 'package:flutter/material.dart';

import '../app.dart';

/// Namespace for Default App Breakpoints
abstract class AppBreakpoint {
  static const double xsMobile = 270;
  static const double sMobile = 350;
  static const double mobile = 450;
  static const double lMobile = 550;
  static const double sTablet = 650;
  static const double tablet = 720;
  static const double lTablet = 860;
  static const double xlTablet = 950;
  static const double sDesktop = 1200;
  static const double desktop = 1300;
  static const double lDesktop = 1500;
  static const double tv = 2000;

  static ScreenType getScreenType(BuildContext context) {
    // Use .widthPx to detect device type regardless of orientation

    final deviceWidth = context.widthPx;
    if (deviceWidth < AppBreakpoint.xsMobile) {
      return ScreenType.xsMobile;
    }
    if (deviceWidth < AppBreakpoint.sMobile) return ScreenType.sMobile;
    if (deviceWidth < AppBreakpoint.mobile) return ScreenType.mobile;
    if (deviceWidth < AppBreakpoint.lMobile) return ScreenType.lMobile;
    if (deviceWidth < AppBreakpoint.sTablet) return ScreenType.sTablet;
    if (deviceWidth < AppBreakpoint.tablet) return ScreenType.tablet;
    if (deviceWidth < AppBreakpoint.lTablet) return ScreenType.lTablet;
    if (deviceWidth < AppBreakpoint.xlTablet) {
      return ScreenType.xlTablet;
    }
    if (deviceWidth < AppBreakpoint.sDesktop) {
      return ScreenType.sDesktop;
    }
    if (deviceWidth < AppBreakpoint.desktop) return ScreenType.desktop;
    if (deviceWidth < AppBreakpoint.lDesktop) {
      return ScreenType.lDesktop;
    }
    return ScreenType.tv;
  }

  static double _fromScreenType(ScreenType type) {
    switch (type) {
      case ScreenType.xsMobile:
        return AppBreakpoint.xsMobile;
      case ScreenType.sMobile:
        return AppBreakpoint.sMobile;
      case ScreenType.mobile:
        return AppBreakpoint.mobile;
      case ScreenType.lMobile:
        return AppBreakpoint.lMobile;
      case ScreenType.sTablet:
        return AppBreakpoint.sTablet;
      case ScreenType.tablet:
        return AppBreakpoint.tablet;
      case ScreenType.lTablet:
        return AppBreakpoint.lTablet;
      case ScreenType.xlTablet:
        return AppBreakpoint.xlTablet;
      case ScreenType.sDesktop:
        return AppBreakpoint.sDesktop;
      case ScreenType.desktop:
        return AppBreakpoint.desktop;
      case ScreenType.lDesktop:
        return AppBreakpoint.lDesktop;
      case ScreenType.tv:
        return AppBreakpoint.tv;
    }
  }

  static bool isLargerThan(double deviceWidth, ScreenType type) {
    return deviceWidth > _fromScreenType(type);
  }

  static bool isLargerThanOrEqual(double deviceWidth, ScreenType type) {
    return deviceWidth >= _fromScreenType(type);
  }

  static bool isSmallerThan(double deviceWidth, ScreenType type) {
    return deviceWidth < _fromScreenType(type);
  }

  static bool isSmallerThanOrEqual(double deviceWidth, ScreenType type) {
    return deviceWidth <= _fromScreenType(type);
  }

  static bool isEqualTo(double deviceWidth, ScreenType type) {
    return _fromScreenType(type) == deviceWidth;
  }

  static bool isNotEqualTo(double deviceWidth, ScreenType type) {
    return _fromScreenType(type) != deviceWidth;
  }

  static const double _smallTextScaleFactor = 1;
  static const double _normalTextScaleFactor = 1.1;
  static const double _largeTextScaleFactor = 1.2;

  static double getTextScale(double width) {
    if (AppBreakpoint.isSmallerThan(width, ScreenType.mobile)) {
      return _smallTextScaleFactor;
    } else if (AppBreakpoint.isSmallerThanOrEqual(width, ScreenType.lTablet)) {
      return _normalTextScaleFactor;
    }
    return _largeTextScaleFactor;
  }
}
