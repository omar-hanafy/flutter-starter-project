import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter/features/new_feature/feature.dart';

import '../../../features/new_feature/view/feature_view.dart';
import '../../../lib.dart';

abstract class _RouterManager {
  static RouteBase feature({
    String? subRouteKey,
    List<RouteBase> subRoutes = const [],
  }) =>
      _generateRoute(
        route: AppRoute.feature,
        subRouteKey: subRouteKey,
        subRoutes: subRoutes,
        pageBuilder: (_, state) => _pageBuilder(
          state,
          child: FeatureView(params: state.extra),
        ),
      );

  static List<RouteBase> get globalRoutes => [
        feature(),
      ];

  static List<RouteBase> get homeSubRoutes => [
        feature(subRouteKey: 'home'),
      ];

  static RouteBase _generateRoute({
    required AppRoute route,
    Widget? child,
    GoRouterPageBuilder? pageBuilder,
    List<RouteBase> subRoutes = const [],

    /// the subRoute key will be the path of the parent routes.
    /// for example lets say we have cart route under home branch, if you want
    /// to add a new route called product under the cart. the hierarchy should
    /// be something like that:
    ///  home --- no subRouteKey cause it is parent
    ///    cart --- subRouteKey = 'home'
    ///      Product --- subRouteKey = 'home/cart'
    /// note that all branches and global routes should not have 'subRouteKey'.
    /// if subRouteKey is provided the to a global branch the navigation helper
    /// will consider it a subRoute and thus navigating to this route will give
    /// you 404.
    String? subRouteKey,
  }) {
    final isSub = subRouteKey.isNotEmptyOrNull;
    assert(
      isSub && !route.isGlobalOnly || !isSub,
      'global only routes should not have a subRouteKey. StackTrace: ${StackTrace.current}',
    );
    assert(
      pageBuilder.isNotNull || child.isNotNull,
      'either pageBuilder or child must be provided',
    );
    return GoRoute(
      /// we pass the root key to all routes that will be in the global routes.
      parentNavigatorKey: isSub ? null : MainRouter.rootKey,

      /// note that sub routes should not take the [route.path] instead we use
      /// the [route.name]
      path: isSub ? route.name : route.routePath,
      name: isSub ? route.nameWithKey(subRouteKey!) : route.name,
      routes: subRoutes,
      pageBuilder:
          pageBuilder ?? (_, state) => _pageBuilder(state, child: child!),
    );
  }

  static Page<dynamic> _pageBuilder(
    GoRouterState state, {
    required Widget child,
  }) {
    return kIsWeb
        ? NoTransitionPage<void>(key: state.pageKey, child: child)
        : MaterialPage<void>(key: state.pageKey, child: child);
  }

  static RouteBase generateBranchRoute({
    required AppRoute route,
    required Widget child,
    List<RouteBase> subRoutes = const [],
  }) {
    return GoRoute(
      path: route.routePath,
      name: route.name,
      routes: subRoutes,
      pageBuilder: (_, __) => MaterialPage(child: child),
    );
  }
}

abstract class MainRouter {
  static final rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GoRouter router = GoRouter(
    navigatorKey: rootKey,
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
          homeBranch,
          exploreBranch,
          cartBranch,
          ordersBranch,
          accountBranch,
        ],
      ),
      ..._RouterManager.globalRoutes,
    ],
  );

  static StatefulShellBranch get homeBranch {
    return StatefulShellBranch(
      navigatorKey: GlobalKey(debugLabel: AppRoute.home.branchKey),
      routes: [
        _RouterManager.generateBranchRoute(
          route: AppRoute.home,
          child: const HomeView(),
          subRoutes: _RouterManager.homeSubRoutes,
        ),
      ],
    );
  }

  static StatefulShellBranch get exploreBranch => StatefulShellBranch(
        navigatorKey: GlobalKey(debugLabel: AppRoute.explore.branchKey),
        routes: [
          _RouterManager.generateBranchRoute(
            route: AppRoute.explore,
            child: const ExploreView(),
          ),
        ],
      );

  static StatefulShellBranch get cartBranch => StatefulShellBranch(
        navigatorKey: GlobalKey(debugLabel: AppRoute.cart.branchKey),
        routes: [
          _RouterManager.generateBranchRoute(
            route: AppRoute.cart,
            child: const CartView(),
          ),
        ],
      );

  static StatefulShellBranch get ordersBranch => StatefulShellBranch(
        navigatorKey: GlobalKey(debugLabel: AppRoute.orders.branchKey),
        routes: [
          _RouterManager.generateBranchRoute(
            route: AppRoute.orders,
            child: const OrdersView(),
          ),
        ],
      );

  static StatefulShellBranch get accountBranch => StatefulShellBranch(
        navigatorKey: GlobalKey(debugLabel: AppRoute.account.branchKey),
        routes: [
          _RouterManager.generateBranchRoute(
            route: AppRoute.account,
            child: const AccountView(),
          ),
        ],
      );
}
