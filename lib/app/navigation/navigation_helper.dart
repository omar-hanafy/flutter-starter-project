import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../lib.dart';

extension NavigationHelperExtension on BuildContext {
  void pushNamed(
          {bool pushGlobally = false,
          required RouteName name,
          Map<String, String> queryParams = const {}}) =>
      NavigationHelper(this).pushNamed(
          name: name, pushGlobally: pushGlobally, queryParams: queryParams);
}

class NavigationHelper {
  NavigationHelper(this.context);

  final BuildContext context;

  late final navCubit = context.read<NavigationBarCubit>();

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
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColor.primaryColor,
          icon: const Icon(AppIcon.searchOutlined),
          label: AppLocalizations.of(context)!.explore,
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColor.primaryColor,
          icon: const Icon(AppIcon.shoppingCartOutlined),
          label: AppLocalizations.of(context)!.cart,
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColor.primaryColor,
          icon: const Icon(AppIcon.archiveOutlined),
          label: AppLocalizations.of(context)!.orders,
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColor.primaryColor,
          icon: const Icon(AppIcon.personOutlined),
          label: AppLocalizations.of(context)!.account,
        ),
      ];

  // for desktop
  List<NavigationRailDestination> get desktopNavItems => [
        NavigationRailDestination(
          icon: const Icon(AppIcon.homeOutlined),
          label: Text(AppLocalizations.of(context)!.home),
        ),
        NavigationRailDestination(
          icon: const Icon(AppIcon.searchOutlined),
          label: Text(AppLocalizations.of(context)!.explore),
        ),
        NavigationRailDestination(
          icon: const Icon(AppIcon.shoppingCartOutlined),
          label: Text(AppLocalizations.of(context)!.cart),
        ),
        NavigationRailDestination(
          icon: const Icon(AppIcon.archiveOutlined),
          label: Text(AppLocalizations.of(context)!.orders),
        ),
        NavigationRailDestination(
          icon: const Icon(AppIcon.personOutlined),
          label: Text(AppLocalizations.of(context)!.account),
        ),
      ];

  // for web (customized)
  List<WebNavBarItem> get webNavItems => [
        WebNavBarItem(
            icon: const Icon(AppIcon.homeOutlined),
            routeName: RouteName.home,
            label: AppLocalizations.of(context)!.home),
        WebNavBarItem(
            icon: const Icon(AppIcon.searchOutlined),
            routeName: RouteName.explore,
            label: AppLocalizations.of(context)!.explore),
        WebNavBarItem(
            icon: const Icon(AppIcon.shoppingCartOutlined),
            routeName: RouteName.cart,
            label: AppLocalizations.of(context)!.cart),
        WebNavBarItem(
            icon: const Icon(AppIcon.archiveOutlined),
            routeName: RouteName.orders,
            label: AppLocalizations.of(context)!.orders),
        WebNavBarItem(
            icon: const Icon(AppIcon.personOutlined),
            routeName: RouteName.account,
            label: AppLocalizations.of(context)!.account),
      ];

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

  void pushNamed(
      {bool pushGlobally = false,
      required RouteName name,
      Map<String, String> queryParams = const {}}) {
    if (kIsWeb || pushGlobally) {
      AppRouter.appRouter.goNamed(name.name, queryParams: queryParams);
    } else {
      if (NavigationHelper.navPageRouters.length <= name.index) {
        navCubit.goName(name);
      } else {
        _getState.pushNamed(name.name, queryParams: queryParams);
      }
    }
  }

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

  void pushReplacement(
      {required RouteName name, Map<String, String> queryParams = const {}}) {}
}
