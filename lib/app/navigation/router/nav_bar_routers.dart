import 'package:flutter/material.dart';

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
    initialLocation: RouteName.home.routePath,
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            RouteName.home.routePath,
      ),
      GoRoute(
        path: RouteName.home.routePath,
        routes: SubRoutes.home,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: HomeView(),
          );
        },
      ),
    ],
  );

  static final GoRouter _exploreRouter = GoRouter(
    initialLocation: RouteName.explore.routePath,
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            RouteName.explore.routePath,
      ),
      GoRoute(
        path: RouteName.explore.routePath,
        routes: SubRoutes.explore,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ExploreView(),
          );
        },
      ),
    ],
  );

  static final GoRouter _cartRouter = GoRouter(
    initialLocation: RouteName.cart.routePath,
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            RouteName.cart.routePath,
      ),
      GoRoute(
        path: RouteName.cart.routePath,
        routes: SubRoutes.carte,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CartView(),
          );
        },
      ),
    ],
  );

  static final GoRouter _ordersRouter = GoRouter(
    initialLocation: RouteName.orders.routePath,
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            RouteName.orders.routePath,
      ),
      GoRoute(
        path: RouteName.orders.routePath,
        routes: SubRoutes.orders,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: OrdersView(),
          );
        },
      ),
    ],
  );

  static final GoRouter _accountRouter = GoRouter(
    initialLocation: RouteName.account.routePath,
    // errorBuilder: (BuildContext context, GoRouterState state) =>
    //     ErrorPage(state: state),
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) =>
            RouteName.account.routePath,
      ),
      GoRoute(
        path: RouteName.account.routePath,
        routes: SubRoutes.account,
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
