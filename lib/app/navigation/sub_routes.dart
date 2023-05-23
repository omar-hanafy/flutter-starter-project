import 'package:flutter/material.dart';

import '../app.dart';

abstract class SubRoutes {
  static GoRoute _myAppRoute({
    required RouteName routeName,
    required Widget child,
  }) =>
      GoRoute(
        path: routeName.routeName,
        name: routeName.routeName,
        pageBuilder: (_, __) => MaterialPage(child: child),
      );

  static final List<RouteBase> home = [
    // _myAppRoute(routeName: RouteName.homeTwo),
  ];

  static final List<RouteBase> explore = [
    // _myAppRoute(uniqueId: "works/")
  ];

  static final List<RouteBase> cart = [
    // _myAppRoute(uniqueId: "resume/")
  ];

  static final List<RouteBase> orders = [
    // _myAppRoute(uniqueId: "about/"),
    // contactRoute(uniqueId: "about/")
  ];

  static final List<RouteBase> account = [
    // _myAppRoute(uniqueId: "about/"),
    // contactRoute(uniqueId: "about/")
  ];
}
