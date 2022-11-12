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
                    '/${RoutePaths.home}',
              ),
              GoRoute(
                path: '/${RoutePaths.home}',
                name: RoutePaths.home,
                routes: homeSubRoutes,
                pageBuilder: (context, state) => _pageBuilder(context, state,
                    child:
                        kIsWeb ? const HomeView() : const AppNavigationBar()),
              ),
              GoRoute(
                path: '/${RoutePaths.explore}',
                name: RoutePaths.explore,
                routes: exploreSubRoutes,
                pageBuilder: (context, state) =>
                    _pageBuilder(context, state, child: const ExploreView()),
              ),
              GoRoute(
                path: '/${RoutePaths.cart}',
                name: RoutePaths.cart,
                routes: carteSubRoutes,
                pageBuilder: (context, state) =>
                    _pageBuilder(context, state, child: const CartView()),
              ),
              GoRoute(
                path: '/${RoutePaths.orders}',
                name: RoutePaths.orders,
                routes: ordersSubRoutes,
                pageBuilder: (context, state) =>
                    _pageBuilder(context, state, child: const OrdersView()),
              ),
              GoRoute(
                path: '/${RoutePaths.account}',
                name: RoutePaths.account,
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
          initialLocation: '/${RoutePaths.home}',
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

abstract class RoutePaths {
  static const String home = 'home';
  static const String explore = 'explore';
  static const String cart = 'cart';
  static const String orders = 'orders';
  static const String account = 'account';

  static String getTitle(BuildContext context) {
    final navigationHelper = NavigationHelper(context);
    switch (navigationHelper.lastPage) {
      case RoutePaths.home:
        return 'Home';
      case RoutePaths.explore:
        return 'Explore';
      case RoutePaths.cart:
        return 'Cart';
      case RoutePaths.orders:
        return 'Orders';
      case RoutePaths.account:
        return 'Account';
      default:
        return '';
    }
  }
}
