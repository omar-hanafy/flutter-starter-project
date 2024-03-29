import '../layout.dart';

extension ScreenTypeExtension on ScreenType {
  double get toDouble {
    switch (this) {
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
}
