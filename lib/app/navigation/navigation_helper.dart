import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../lib.dart';

class NavigationHelper {
  NavigationHelper(this.context);

  final BuildContext context;

  late final navCubit = context.navigationBarCubit;

  // for non web
  static final List<Widget> _navPageRouters = [
    NavBarItemRouter(router: NavBarRouters.homeRouter),
    NavBarItemRouter(router: NavBarRouters.exploreRouter),
    NavBarItemRouter(router: NavBarRouters.cartRouter),
    NavBarItemRouter(router: NavBarRouters.ordersRouter),
    NavBarItemRouter(router: NavBarRouters.accountRouter),
  ];

  static List<Widget> get navPageRouters => _navPageRouters;

  // for mobile
  List<BottomNavigationBarItem> get mobileNavItems => [
        BottomNavigationBarItem(
          backgroundColor: AppColor.primaryColor,
          icon: const Icon(AppIcon.homeOutlined),
          label: context.l10n.home,
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColor.primaryColor,
          icon: const Icon(AppIcon.searchOutlined),
          label: context.l10n.explore,
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColor.primaryColor,
          icon: const Icon(AppIcon.shoppingCartOutlined),
          label: context.l10n.cart,
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColor.primaryColor,
          icon: const Icon(AppIcon.archiveOutlined),
          label: context.l10n.orders,
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColor.primaryColor,
          icon: const Icon(AppIcon.personOutlined),
          label: context.l10n.account,
        ),
      ];

  // for desktop
  List<NavigationRailDestination> get desktopNavItems => [
        NavigationRailDestination(
          icon: const Icon(AppIcon.homeOutlined),
          label: Text(
            context.l10n.home,
          ),
        ),
        NavigationRailDestination(
          icon: const Icon(AppIcon.searchOutlined),
          label: Text(
            context.l10n.explore,
          ),
        ),
        NavigationRailDestination(
          icon: const Icon(AppIcon.shoppingCartOutlined),
          label: Text(
            context.l10n.cart,
          ),
        ),
        NavigationRailDestination(
          icon: const Icon(AppIcon.archiveOutlined),
          label: Text(
            context.l10n.orders,
          ),
        ),
        NavigationRailDestination(
          icon: const Icon(AppIcon.personOutlined),
          label: Text(
            context.l10n.account,
          ),
        ),
      ];

  // for web (customized)
  List<WebNavBarItem> get webNavItems => [
        WebNavBarItem(
          icon: const Icon(AppIcon.homeOutlined),
          routeName: RouteName.home,
          label: context.l10n.home,
        ),
        WebNavBarItem(
          icon: const Icon(AppIcon.searchOutlined),
          routeName: RouteName.explore,
          label: context.l10n.explore,
        ),
        WebNavBarItem(
          icon: const Icon(AppIcon.shoppingCartOutlined),
          routeName: RouteName.cart,
          label: context.l10n.cart,
        ),
        WebNavBarItem(
          icon: const Icon(AppIcon.archiveOutlined),
          routeName: RouteName.orders,
          label: context.l10n.orders,
        ),
        WebNavBarItem(
          icon: const Icon(AppIcon.personOutlined),
          routeName: RouteName.account,
          label: context.l10n.account,
        ),
      ];

  GoRouter get _getState {
    if (kIsWeb) {
      return AppRouter.appRouter;
    } else {
      switch (navCubit.state.index) {
        case 0:
          return NavBarRouters.homeRouter;
        case 1:
          return NavBarRouters.exploreRouter;
        case 2:
          return NavBarRouters.cartRouter;
        case 3:
          return NavBarRouters.ordersRouter;
        case 4:
          return NavBarRouters.accountRouter;
        default:
          return NavBarRouters.homeRouter;
      }
    }
  }

  List<String> get pages {
    var location = _getState.location;
    if (location == '/') {
      return kIsWeb ? ['home'] : [navCubit.state.index.getRouteName.name];
    } else if (location.startsWith('/')) {
      location = location.substring(1);
    }
    return location.split('?').first.split('/');
  }

  String get lastPage => pages.last;

  String get firstPage => pages.first;

  Map<String, String> get arguments {
    final argsMap = <String, String>{};
    final location = _getState.location;
    if (location.contains('?')) {
      final argsList = location.split('?').last.split('&');
      for (final element in argsList) {
        if (element.contains('=')) {
          final list = element.split('=');
          argsMap[list.first] = list.last;
        }
      }
    }
    return argsMap;
  }

  String get getTitle => lastPage.getRouteName.fullName;

  void pushNamed({
    bool pushGlobally = false,
    required RouteName routeName,
    Map<String, String> queryParams = const {},
  }) {
    if (kIsWeb || pushGlobally) {
      AppRouter.appRouter.goNamed(routeName.name, queryParams: queryParams);
    } else {
      if (_navPageRouters.length <= routeName.index) {
        /// only change navigation bar index.
        navCubit.goName(routeName);
      } else {
        /// navigating using the router of the current navigation bar index
        _getState.goNamed(routeName.name, queryParams: queryParams);
      }
    }
  }

  void pushReplacement({
    bool pushGlobally = false,
    required RouteName routeName,
    Map<String, String> queryParams = const {},
  }) {
    if (kIsWeb || pushGlobally) {
      AppRouter.appRouter.pushReplacementNamed(
        routeName.name,
        queryParams: queryParams,
      );
    } else {
      if (_navPageRouters.length <= routeName.index) {
        /// only change navigation bar index.
        navCubit.goName(routeName);
      } else {
        /// navigating using the router of the current navigation bar index
        _getState.pushReplacementNamed(
          routeName.name,
          queryParams: queryParams,
        );
      }
    }
  }
}
