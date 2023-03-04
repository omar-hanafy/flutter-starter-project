import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../lib.dart';

class AppRouter {
  static Page<dynamic> _pageBuilder(BuildContext context, GoRouterState state,
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
    initialLocation: RouteName.home.path,
    navigatorKey: _rootNavigatorKey,
    errorPageBuilder: (context, state) => _pageBuilder(context, state,
        child: RouterErrorPageBuilder(routerState: state)),
    errorBuilder: (context, state) =>
        RouterErrorPageBuilder(routerState: state),
    // redirect to the login page if the user is not logged in
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) =>
            RouterPageBuilder(state: state, child: child),
        routes: <RouteBase>[
          // above is the GoRoute for the nav bar items only.
          GoRoute(
            path: '/',
            redirect: (context, state) => RouteName.home.path,
          ),
          GoRoute(
            path: RouteName.login.path,
            name: RouteName.login.name,
            routes: exploreSubRoutes,
            pageBuilder: (context, state) => _pageBuilder(
              context,
              state,
              child: const ExploreView(),
            ),
          ),
          GoRoute(
            path: RouteName.home.path,
            name: RouteName.home.name,
            routes: homeSubRoutes,
            pageBuilder: (context, state) {
              return _pageBuilder(context, state,
                  child: kIsWeb
                      ? const HomeView()
                      : context.isDesktop
                          ? const DesktopNavigationBar()
                          : const MobileNavigationBar());
            },
          ),
          GoRoute(
            path: RouteName.explore.path,
            name: RouteName.explore.name,
            routes: exploreSubRoutes,
            pageBuilder: (context, state) => _pageBuilder(
              context,
              state,
              child: const ExploreView(),
            ),
          ),
          GoRoute(
            path: RouteName.cart.path,
            name: RouteName.cart.name,
            routes: carteSubRoutes,
            pageBuilder: (context, state) => _pageBuilder(
              context,
              state,
              child: const CartView(),
            ),
          ),
          GoRoute(
            path: RouteName.orders.path,
            name: RouteName.orders.name,
            routes: ordersSubRoutes,
            pageBuilder: (context, state) => _pageBuilder(
              context,
              state,
              child: const OrdersView(),
            ),
          ),
          GoRoute(
            path: RouteName.account.path,
            name: RouteName.account.name,
            routes: accountSubRoutes,
            pageBuilder: (context, state) => _pageBuilder(
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
  const RouterPageBuilder(
      {super.key, required this.child, required this.state});

  final Widget child;
  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    debugPrint('location name is ${state.name}');
    const locale = Locale('EN', 'EG');
    return BlocBuilder<ThemeBloc, Brightness>(
      builder: (context, brightness) {
        return Theme(
          data: AppTheme.getAdaptiveTheme(brightness),
          child: Localizations(
            locale: locale,
            delegates: AppLocalizations.localizationsDelegates,
            child: Builder(builder: (context) {
              return MediaQuery(
                data: context.mq
                    .copyWith(textScaleFactor: context.textScaleFactor),
                child: kIsWeb ? WebNavigationBar(child: child) : child,
              );
            }),
          ),
        );
      },
    );
  }
}

class RouterErrorPageBuilder extends StatelessWidget {
  const RouterErrorPageBuilder({super.key, required this.routerState});

  final GoRouterState routerState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, Brightness>(
      builder: (context, brightness) {
        const locale = Locale('EN', 'EG');
        return Theme(
          data: AppTheme.getAdaptiveTheme(brightness),
          child: Localizations(
            locale: locale,
            delegates: AppLocalizations.localizationsDelegates,
            child: Builder(builder: (context) {
              return MediaQuery(
                data: context.mq
                    .copyWith(textScaleFactor: context.textScaleFactor),
                child: WebNavigationBar(
                    child: Center(child: Text('${routerState.error}'))),
              );
            }),
          ),
        );
      },
    );
  }
}
