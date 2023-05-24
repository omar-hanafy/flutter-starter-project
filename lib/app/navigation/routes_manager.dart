import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter/features/new_feature/feature.dart';

import '../../features/new_feature/view/feature_view.dart';
import '../../lib.dart';

enum AppRoute {
  home,
  explore,
  cart,
  orders,
  account,
  feature,
  notFound,
}

abstract class RouterManager {
  static final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  static RouteBase _generateRoute(
          {required AppRoute route,
          required Widget child,
          List<RouteBase> subRoutes = const [],
          String? subRouteKey,
          GlobalKey<NavigatorState>? parentNavigatorKey}) =>
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,

        /// note that sub routes should not take the [route.path] instead we use
        /// the [route.name]
        path: subRouteKey.isNotEmptyOrNull ? route.name : route.routePath,
        name: subRouteKey.isNotEmptyOrNull
            ? route.nameWithKey(subRouteKey!)
            : route.name,
        routes: subRoutes,
        pageBuilder: (_, __) => MaterialPage(child: child),
      );

  static RouteBase feature({
    String? subRouteKey,
    GlobalKey<NavigatorState>? parentNavigatorKey,
    List<RouteBase> subRoutes = const [],
  }) =>
      _generateRoute(
        parentNavigatorKey: parentNavigatorKey,
        route: AppRoute.feature,
        child: const FeatureView(),
        subRouteKey: subRouteKey,
        subRoutes: subRoutes,
      );

  static List<RouteBase> get globalRoutes => [
        feature(parentNavigatorKey: _rootKey),
      ];

  static StatefulShellBranch get homeBranch {
    return StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: '_homeRouter'),
      routes: [
        _generateRoute(
          route: AppRoute.home,
          child: const HomeView(),
          subRoutes: [
            feature(
              subRouteKey: 'home',
              subRoutes: [
                feature(subRouteKey: 'home/feature'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  static StatefulShellBranch get exploreBranch => StatefulShellBranch(
        navigatorKey: GlobalKey<NavigatorState>(debugLabel: '_exploreRouter'),
        routes: [
          _generateRoute(
            route: AppRoute.explore,
            child: const ExploreView(),
          ),
        ],
      );

  static StatefulShellBranch get cartBranch => StatefulShellBranch(
        navigatorKey: GlobalKey<NavigatorState>(debugLabel: '_cartRouter'),
        routes: [
          _generateRoute(
            route: AppRoute.cart,
            child: const CartView(),
          ),
        ],
      );

  static StatefulShellBranch get ordersBranch => StatefulShellBranch(
        navigatorKey: GlobalKey<NavigatorState>(debugLabel: '_ordersRouter'),
        routes: [
          _generateRoute(
            route: AppRoute.orders,
            child: const OrdersView(),
          ),
        ],
      );

  static StatefulShellBranch get accountBranch => StatefulShellBranch(
        navigatorKey: GlobalKey<NavigatorState>(debugLabel: '_accountRouter'),
        routes: [
          _generateRoute(
            route: AppRoute.account,
            child: const AccountView(),
          ),
        ],
      );

  static GoRouter get router => GoRouter(
        navigatorKey: _rootKey,
        initialLocation: AppRoute.home.routePath,
        observers: <NavigatorObserver>[AppRouterObserver()],
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            redirect: (BuildContext context, GoRouterState state) =>
                AppRoute.home.routePath,
          ),
          StatefulShellRoute.indexedStack(
            builder: (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell ns,
            ) {
              return BlocProvider(
                create: (_) => NavigationCubit(ns),
                child: Builder(
                  builder: (context) {
                    context.navigationCubit.reBuild(ns);
                    return kIsWeb
                        ? const WebBar()
                        : context.isDesktop
                            ? const DesktopNavigationBar()
                            : const MobileNavigationBar();
                  },
                ),
              );
            },
            branches: <StatefulShellBranch>[
              RouterManager.homeBranch,
              RouterManager.exploreBranch,
              RouterManager.cartBranch,
              RouterManager.ordersBranch,
              RouterManager.accountBranch,
            ],
          ),
          ...RouterManager.globalRoutes,
        ],
      );
}
