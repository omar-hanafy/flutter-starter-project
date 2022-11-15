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
    observers: <NavigatorObserver>[AppNavObserver()],
    initialLocation: '/${RouteName.home.name}',
    navigatorKey: _rootNavigatorKey,
    errorPageBuilder: (context, state) => _pageBuilder(context, state,
        child: RouterErrorPageBuilder(routerState: state)),
    errorBuilder: (context, state) =>
        RouterErrorPageBuilder(routerState: state),
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => RouterPageBuilder(child: child),
        routes: <RouteBase>[
          // above is the GoRoute for the nav bar items only.
          GoRoute(
              path: '/',
              redirect: (context, state) => '/${RouteName.home.name}'),
          GoRoute(
              path: '/${RouteName.home.name}',
              name: RouteName.home.name,
              routes: homeSubRoutes,
              pageBuilder: (context, state) {
                return _pageBuilder(context, state,
                    child: kIsWeb
                        ? const HomeView()
                        : context.isDesktop
                            ? const DesktopNavigationBar()
                            : const MobileNavigationBar());
              }),
          GoRoute(
            path: '/${RouteName.explore.name}',
            name: RouteName.explore.name,
            routes: exploreSubRoutes,
            pageBuilder: (context, state) =>
                _pageBuilder(context, state, child: const ExploreView()),
          ),
          GoRoute(
            path: '/${RouteName.cart.name}',
            name: RouteName.cart.name,
            routes: carteSubRoutes,
            pageBuilder: (context, state) =>
                _pageBuilder(context, state, child: const CartView()),
          ),
          GoRoute(
            path: '/${RouteName.orders.name}',
            name: RouteName.orders.name,
            routes: ordersSubRoutes,
            pageBuilder: (context, state) =>
                _pageBuilder(context, state, child: const OrdersView()),
          ),
          GoRoute(
            path: '/${RouteName.account.name}',
            name: RouteName.account.name,
            routes: accountSubRoutes,
            pageBuilder: (context, state) =>
                _pageBuilder(context, state, child: const AccountView()),
          ),
        ],
      ),
    ],
  );

  static GoRouter get appRouter => _appRouter;
}

class RouterPageBuilder extends StatelessWidget {
  const RouterPageBuilder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, Brightness>(
      builder: (context, brightness) {
        return Theme(
          data: AppTheme.getAdaptiveTheme(brightness),
          child: Localizations(
            locale: const Locale('en'),
            delegates: AppLocalizations.localizationsDelegates,
            child: Builder(builder: (context) {
              return MediaQuery(
                data: context.mq.copyWith(
                    textScaleFactor:
                        AppBreakpoint.getTextScale(context.widthPx)),
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
        return Theme(
          data: AppTheme.getAdaptiveTheme(brightness),
          child: Localizations(
            locale: const Locale('en'),
            delegates: AppLocalizations.localizationsDelegates,
            child: Builder(builder: (context) {
              return MediaQuery(
                data: context.mq.copyWith(
                    textScaleFactor:
                        AppBreakpoint.getTextScale(context.widthPx)),
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
