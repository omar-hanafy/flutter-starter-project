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
    initialLocation: '/${RouteName.home.name}',
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            '/${RouteName.home.name}',
      ),
      GoRoute(
        path: '/${RouteName.home.name}',
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
    initialLocation: '/${RouteName.explore.name}',
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            '/${RouteName.explore.name}',
      ),
      GoRoute(
        path: '/${RouteName.explore.name}',
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
    initialLocation: '/${RouteName.cart.name}',
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            '/${RouteName.cart.name}',
      ),
      GoRoute(
        path: '/${RouteName.cart.name}',
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
    initialLocation: '/${RouteName.orders.name}',
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            '/${RouteName.orders.name}',
      ),
      GoRoute(
        path: '/${RouteName.orders.name}',
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
    initialLocation: '/${RouteName.account.name}',
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            '/${RouteName.account.name}',
      ),
      GoRoute(
        path: '/${RouteName.account.name}',
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
