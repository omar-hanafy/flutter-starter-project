import 'package:flutter/material.dart';

import '../../app.dart';

extension NavigationExtension on BuildContext {
  Future<T?> goPush<T extends Object?>(
    AppRoute route, {
    bool pushGlobally = false,
    bool forcePushToSubRoutes = false,
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) async {
    if (route.isRouterBranch) {
      navigationCubit.goIndex(route.branchIndex);
      return null;
    }
    try {
      return GoRouter.of(this).pushNamed<T>(
        pushGlobally ? route.name : _getSubRouteName(route),
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
    } catch (_) {
      if (!forcePushToSubRoutes) {
        return GoRouter.of(this).pushNamed<T>(
          route.name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
          extra: extra,
        );
      } else {
        rethrow;
      }
    }
  }

  void pushRouteReplacement(
    AppRoute route, {
    bool pushGlobally = false,
    Map<String, String> queryParams = const {},
  }) {
    GoRouter.of(this).pushReplacementNamed(
      route.name,
      pathParameters: queryParams,
    );
  }

  String _getSubRouteName(AppRoute route) {
    final name = routeName;
    if (appRoute == route) return name;
    return '$name/${route.name}';
  }

  AppRoute get appRoute => routeName.split('/').last.appRoute;

  GoRouter get router => GoRouter.of(this);

  GoRouterState get routeState => GoRouterState.of(this);

  String get _routeLocation => router.location;

  String get routeName {
    var loc = _routeLocation;
    print(loc);
    if (loc == '/') return 'home';
    if (loc.startsWith('/')) loc = loc.substring(1);
    if (loc.endsWith('/')) loc = loc.substring(0, loc.length - 1);
    loc = loc.split('?').first;
    loc = loc.split(':').first;
    return loc;
  }
}

extension StatefulNavigationShellEx on StatefulNavigationShell {
  void goIndex(int index) {
    goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == currentIndex,
    );
  }
}

extension AppRouteOtherExtension on AppRoute {
  bool get isHome => this == AppRoute.home;

  bool get isExplore => this == AppRoute.explore;

  bool get isCart => this == AppRoute.cart;

  bool get isOrders => this == AppRoute.orders;

  bool get isAccount => this == AppRoute.account;

  bool get isFeature => this == AppRoute.feature;

  bool get isNotFound => this == AppRoute.notFound;

  bool get isRouterBranch =>
      isHome || isExplore || isCart || isOrders || isAccount;

  String get routePath => '/$name';

  String nameWithKey(String key) => '$key/$name';

  int get branchIndex {
    if (isExplore) return 1;
    if (isCart) return 2;
    if (isOrders) return 3;
    if (isAccount) return 4;
    return 0;
  }
}

extension AppRouteStringExtension on String? {
  AppRoute get appRoute {
    switch (this?.toLowerCase()) {
      case 'home':
        return AppRoute.home;
      case 'explore':
        return AppRoute.explore;
      case 'cart':
        return AppRoute.cart;
      case 'orders':
        return AppRoute.orders;
      case 'account':
        return AppRoute.account;
      case 'feature':
        return AppRoute.feature;
      default:
        return AppRoute.notFound;
    }
  }
}
