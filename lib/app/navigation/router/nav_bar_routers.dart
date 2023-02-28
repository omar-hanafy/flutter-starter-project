import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../lib.dart';

class NavBarItemRouter extends StatelessWidget {
  const NavBarItemRouter({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
    );
  }
}

class NavBarRouters {
  static final GoRouter _homeRouter = GoRouter(
    initialLocation: RouteName.home.path,
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            RouteName.home.path,
      ),
      GoRoute(
        path: RouteName.home.path,
        routes: homeSubRoutes,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: HomeView(),
          );
        },
      ),
    ],
  );

  static final GoRouter _exploreRouter = GoRouter(
    initialLocation: RouteName.explore.path,
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            RouteName.explore.path,
      ),
      GoRoute(
        path: RouteName.explore.path,
        routes: exploreSubRoutes,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ExploreView(),
          );
        },
      ),
    ],
  );

  static final GoRouter _cartRouter = GoRouter(
    initialLocation: RouteName.cart.path,
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            RouteName.cart.path,
      ),
      GoRoute(
        path: RouteName.cart.path,
        routes: carteSubRoutes,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CartView(),
          );
        },
      ),
    ],
  );

  static final GoRouter _ordersRouter = GoRouter(
    initialLocation: RouteName.orders.path,
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            RouteName.orders.path,
      ),
      GoRoute(
        path: RouteName.orders.path,
        routes: ordersSubRoutes,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: OrdersView(),
          );
        },
      ),
    ],
  );

  static final GoRouter _accountRouter = GoRouter(
    initialLocation: RouteName.account.path,
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            RouteName.account.path,
      ),
      GoRoute(
        path: RouteName.account.path,
        routes: accountSubRoutes,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: AccountView(),
          );
        },
      ),
    ],
  );

  static GoRouter get homeRouter => _homeRouter;

  static GoRouter get exploreRouter => _exploreRouter;

  static GoRouter get cartRouter => _cartRouter;

  static GoRouter get ordersRouter => _ordersRouter;

  static GoRouter get accountRouter => _accountRouter;
}
