import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../lib.dart';

class AppRouter {
  static Page<dynamic> pageBuilder(BuildContext context, GoRouterState state,
      {required Widget child}) {
    return kIsWeb
        ? NoTransitionPage<void>(
            key: state.pageKey,
            child: child,
          )
        : MaterialPage<void>(key: state.pageKey, child: child);
  }

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  static final GoRouter _appRouter = GoRouter(
    observers: <NavigatorObserver>[AppRouterObserver()],
    initialLocation: RouteName.home.routePath,
    navigatorKey: _rootNavigatorKey,
    errorPageBuilder: (context, state) => pageBuilder(context, state,
        child: RouterErrorPageBuilder(routerState: state)),
    errorBuilder: (context, state) =>
        RouterErrorPageBuilder(routerState: state),
    // redirect to the login page if the user is not logged in
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => RouterPageBuilder(
          state: state,
          child: child,
        ),
        routes: <RouteBase>[
          // above is the GoRoute for the nav bar items only.
          GoRoute(
            path: '/',
            redirect: (context, state) => RouteName.home.routePath,
          ),
          GoRoute(
            path: RouteName.home.routePath,
            name: RouteName.home.routeName,
            routes: SubRoutes.home,
            pageBuilder: (context, state) {
              return pageBuilder(context, state,
                  child: kIsWeb
                      ? const HomeView()
                      : context.isDesktop
                          ? const DesktopNavigationBar()
                          : const MobileNavigationBar());
            },
          ),
          GoRoute(
            path: RouteName.explore.routePath,
            name: RouteName.explore.routeName,
            routes: SubRoutes.explore,
            pageBuilder: (context, state) => pageBuilder(
              context,
              state,
              child: const ExploreView(),
            ),
          ),
          GoRoute(
            path: RouteName.cart.routePath,
            name: RouteName.cart.routeName,
            routes: SubRoutes.carte,
            pageBuilder: (context, state) => pageBuilder(
              context,
              state,
              child: const CartView(),
            ),
          ),
          GoRoute(
            path: RouteName.orders.routePath,
            name: RouteName.orders.routeName,
            routes: SubRoutes.orders,
            pageBuilder: (context, state) => pageBuilder(
              context,
              state,
              child: const OrdersView(),
            ),
          ),
          GoRoute(
            path: RouteName.account.routePath,
            name: RouteName.account.routeName,
            routes: SubRoutes.account,
            pageBuilder: (context, state) => pageBuilder(
              context,
              state,
              child: const AccountView(),
            ),
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _appRouter;
}

class RouterPageBuilder extends StatelessWidget {
  const RouterPageBuilder({
    super.key,
    required this.child,
    required this.state,
  });

  final Widget child;
  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: context.mq.copyWith(
        textScaleFactor: context.textScaleFactor,
      ),
      child: kIsWeb ? WebNavigationBar(child: child) : child,
    );
  }
}

class RouterErrorPageBuilder extends StatelessWidget {
  const RouterErrorPageBuilder({super.key, required this.routerState});

  final GoRouterState routerState;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: context.mq.copyWith(
        textScaleFactor: context.textScaleFactor,
      ),
      child: WebNavigationBar(
        child: Center(
          child: Text('${routerState.error}'),
        ),
      ),
    );
  }
}
