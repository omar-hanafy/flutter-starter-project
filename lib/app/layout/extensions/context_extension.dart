import 'package:flutter/material.dart';

import '../../app.dart';

extension LayoutExtension on BuildContext {
  ScreenType get screenType {
    final dw = widthPx;
    if (dw < AppBreakpoint.xsMobile) return ScreenType.xsMobile;
    if (dw < AppBreakpoint.sMobile) return ScreenType.sMobile;
    if (dw < AppBreakpoint.mobile) return ScreenType.mobile;
    if (dw < AppBreakpoint.lMobile) return ScreenType.lMobile;
    if (dw < AppBreakpoint.sTablet) return ScreenType.sTablet;
    if (dw < AppBreakpoint.tablet) return ScreenType.tablet;
    if (dw < AppBreakpoint.lTablet) return ScreenType.lTablet;
    if (dw < AppBreakpoint.xlTablet) return ScreenType.xlTablet;
    if (dw < AppBreakpoint.sDesktop) return ScreenType.sDesktop;
    if (dw < AppBreakpoint.desktop) return ScreenType.desktop;
    if (dw < AppBreakpoint.lDesktop) return ScreenType.lDesktop;
    return ScreenType.tv;
  }

  bool isLargerThan(ScreenType type) => widthPx > type.toDouble;

  bool isLargerThanOrEqual(ScreenType type) => widthPx >= type.toDouble;

  bool isSmallerThan(ScreenType type) => widthPx < type.toDouble;

  bool isSmallerThanOrEqual(ScreenType type) => widthPx <= type.toDouble;

  bool isEqualTo(ScreenType type) => widthPx == type.toDouble;

  bool isNotEqualTo(ScreenType type) => widthPx != type.toDouble;

  static const double _smallTextScaleFactor = 1;
  static const double _normalTextScaleFactor = 1.1;
  static const double _largeTextScaleFactor = 1.2;

  double get textScaleFactor {
    if (isSmallerThan(ScreenType.mobile)) {
      return _smallTextScaleFactor;
    } else if (isSmallerThanOrEqual(ScreenType.lTablet)) {
      return _normalTextScaleFactor;
    }
    return _largeTextScaleFactor;
  }
}
