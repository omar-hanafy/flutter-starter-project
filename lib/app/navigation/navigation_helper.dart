import 'package:flutter/material.dart';

import 'navigation.dart';

extension NavigationExtension on BuildContext {
  Future<T?> goPush<T extends Object?>(
    AppRoute route, {
    bool pushGlobally = false,
    bool forcePushToSubRoutes = false,
    RouterBaseArgs? args,
    bool isQueryArgs = true,
    Object? extra,
  }) async {
    if (route.isBranch) {
      navigationCubit.goIndex(route.branchIndex);
      return null;
    } else {
      try {
        return _goPush<T>(
          pushGlobally ? route.name : _getSubRouteName(route),
          args: args,
          isQueryArgs: isQueryArgs,
        );
      } catch (_) {
        if (forcePushToSubRoutes) rethrow;
        return _goPush<T>(route.name, args: args, isQueryArgs: isQueryArgs);
      }
    }
  }

  Future<T?> _goPush<T extends Object?>(
    String name, {
    RouterBaseArgs? args,
    bool isQueryArgs = true,
    Object? extra,
  }) async {
    print(args);
    return GoRouter.of(this).pushNamed<T>(
      name,
      pathParameters: !isQueryArgs ? args?.toQueryParams() ?? {} : {},
      queryParameters: isQueryArgs ? args?.toQueryParams() ?? {} : {},
      extra: extra,
    );
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
    if (loc == '/') return AppRoute.main.name;
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
