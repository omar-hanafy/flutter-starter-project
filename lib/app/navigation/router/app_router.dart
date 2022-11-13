import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../lib.dart';

Page<dynamic> _pageBuilder(BuildContext context, GoRouterState state,
    {required Widget child}) {
  return kIsWeb
      ? NoTransitionPage<void>(
          key: state.pageKey,
          child: child,
        )
      : MaterialPage<void>(key: state.pageKey, child: child);
}

class AppRouterCubit extends Cubit<GoRouter> {
  AppRouterCubit()
      : super(
          GoRouterInitial(
            routes: <RouteBase>[
              // above is the GoRoute for the nav bar items only.
              GoRoute(
                  path: '/',
                  redirect: (BuildContext context, GoRouterState state) =>
                      '/${RouteName.home.name}'),
              GoRoute(
                  path: '/${RouteName.home.name}',
                  name: RouteName.home.name,
                  routes: homeSubRoutes,
                  pageBuilder: (context, state) {
                    final isDesktop = AppBreakpoint.isLargerThan(
                        context.widthPx, ScreenType.tablet);
                    return _pageBuilder(context, state,
                        child: kIsWeb
                            ? const HomeView()
                            : isDesktop
                                ? const MyNavigationRail()
                                : const MyBottomNavBar());
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
        );
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class GoRouterInitial extends GoRouter {
  GoRouterInitial({required List<RouteBase> routes})
      : super(
          observers: <NavigatorObserver>[AppNavObserver()],
          initialLocation: '/${RouteName.home.name}',
          navigatorKey: _rootNavigatorKey,
          errorBuilder: (BuildContext context, GoRouterState state) =>
              RouterErrorPageBuilder(routerState: state),
          routes: [
            ShellRoute(
              navigatorKey: _shellNavigatorKey,
              routes: routes,
              builder:
                  (BuildContext context, GoRouterState state, Widget child) =>
                      RouterPageBuilder(child: child),
            ),
          ],
        );
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
                child: kIsWeb
                    ? WebNavigationBar(child: child)
                    : MultiBlocProvider(providers: [
                        BlocProvider(create: (_) => NavigationBarCubit()),
                        BlocProvider(create: (_) => HomeRouterCubit()),
                        BlocProvider(create: (_) => ExploreRouterCubit()),
                        BlocProvider(create: (_) => CartRouterCubit()),
                        BlocProvider(create: (_) => OrdersRouterCubit()),
                        BlocProvider(create: (_) => AccountRouterCubit())
                      ], child: child),
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
