import '../layout/app_breakpoint.dart';

enum ScreenType {
  xsMobile,
  sMobile,
  mobile,
  lMobile,
  sTablet,
  tablet,
  lTablet,
  xlTablet,
  sDesktop,
  desktop,
  lDesktop,
  tv,
}

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

enum AppStatus { authenticated, unauthenticated }

enum BrightnessTypesEvent {
  dark,
  light,
  system,
  toggle,
}

enum RouteName {
  home,
  explore,
  cart,
  orders,
  account,
  login,
}

extension RouteNameExtension on RouteName {
  String get fullName {
    switch (this) {
      case RouteName.home:
        return 'Home';
      case RouteName.explore:
        return 'Explore';
      case RouteName.cart:
        return 'Cart';
      case RouteName.orders:
        return 'Orders';
      case RouteName.account:
        return 'Account';
      case RouteName.login:
        return 'Login';
    }
  }
}

extension RouteStringExtension on String {
  RouteName get getRouteName {
    switch (toLowerCase()) {
      case 'home':
        return RouteName.home;
      case 'explore':
        return RouteName.explore;
      case 'cart':
        return RouteName.cart;
      case 'orders':
        return RouteName.orders;
      case 'account':
        return RouteName.account;
      case 'login':
        return RouteName.login;
      default:
        return RouteName.home;
    }
  }
}

extension RouteIntExtension on int {
  RouteName get getRouteName => RouteName.values[this];
}
