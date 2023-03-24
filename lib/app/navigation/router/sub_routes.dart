import 'package:flutter/material.dart';

import '../../app.dart';

GoRoute myAppRoute({
  required RouteName routeName,
  required Widget child,
}) =>
    GoRoute(
      path: routeName.routeName,
      name: routeName.routeName,
      routes: exploreSubRoutes,
      pageBuilder: (context, state) => AppRouter.pageBuilder(
        context,
        state,
        child: child,
      ),
    );

final List<RouteBase> homeSubRoutes = [
  // myAppRoute(routeName: RouteName.homeTwo),
];

final List<RouteBase> exploreSubRoutes = [
  // myAppRoute(uniqueId: "works/")
];
final List<RouteBase> carteSubRoutes = [
  // myAppRoute(uniqueId: "resume/")
];
final List<RouteBase> ordersSubRoutes = [
  // myAppRoute(uniqueId: "about/"),
  // contactRoute(uniqueId: "about/")
];
final List<RouteBase> accountSubRoutes = [
  // myAppRoute(uniqueId: "about/"),
  // contactRoute(uniqueId: "about/")
];
