// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../lib.dart';

/// An example demonstrating how to use nested navigators
class AppRouter {
  static final GlobalKey<NavigatorState> _homeRouterNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: '_homeRouter');
  static final GlobalKey<NavigatorState> _exploreRouterNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: '_exploreRouter');
  static final GlobalKey<NavigatorState> _cartRouterNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: '_cartRouter');
  static final GlobalKey<NavigatorState> _ordersRouterNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: '_ordersRouter');
  static final GlobalKey<NavigatorState> _accountRouterNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: '_accountRouter');
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteName.home.routePath,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return kIsWeb
              ? WebBar(navigationShell: navigationShell)
              : context.isDesktop
                  ? DesktopNavigationBar(navigationShell: navigationShell)
                  : MobileNavigationBar(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          _homeBranch,
          _exploreBranch,
          _cartBranch,
          _ordersBranch,
          _accountBranch,
        ],
      ),
    ],
  );

  static final StatefulShellBranch _homeBranch = StatefulShellBranch(
    navigatorKey: _homeRouterNavigatorKey,
    routes: [
      GoRoute(
        path: RouteName.home.routePath,
        name: RouteName.home.name,
        routes: SubRoutes.home,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: HomeView(),
          );
        },
      ),
    ],
  );

  static final StatefulShellBranch _exploreBranch = StatefulShellBranch(
    navigatorKey: _exploreRouterNavigatorKey,
    routes: [
      GoRoute(
        path: RouteName.explore.routePath,
        name: RouteName.explore.name,
        routes: SubRoutes.explore,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ExploreView(),
          );
        },
      ),
    ],
  );

  static final StatefulShellBranch _cartBranch = StatefulShellBranch(
    navigatorKey: _cartRouterNavigatorKey,
    routes: [
      GoRoute(
        path: RouteName.cart.routePath,
        routes: SubRoutes.cart,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CartView(),
          );
        },
      ),
    ],
  );

  static final StatefulShellBranch _ordersBranch = StatefulShellBranch(
    navigatorKey: _ordersRouterNavigatorKey,
    routes: [
      GoRoute(
        path: RouteName.orders.routePath,
        name: RouteName.orders.name,
        routes: SubRoutes.orders,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: OrdersView(),
          );
        },
      ),
    ],
  );

  static final StatefulShellBranch _accountBranch = StatefulShellBranch(
    navigatorKey: _accountRouterNavigatorKey,
    routes: [
      GoRoute(
        path: RouteName.account.routePath,
        name: RouteName.account.name,
        routes: SubRoutes.account,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: AccountView(),
          );
        },
      ),
    ],
  );
// GoRouter get router => _router;
}
