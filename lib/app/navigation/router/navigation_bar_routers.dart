import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../lib.dart';

class HomeNavBarItemRouter extends StatelessWidget {
  const HomeNavBarItemRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: context.read<HomeRouterCubit>().state.routerDelegate,
      routeInformationProvider:
          context.read<HomeRouterCubit>().state.routeInformationProvider,
      routeInformationParser:
          context.read<HomeRouterCubit>().state.routeInformationParser,
    );
  }
}

class HomeRouterCubit extends Cubit<GoRouter> {
  HomeRouterCubit()
      : super(
          GoRouter(
            initialLocation: '/${RoutePaths.home}',
            // errorBuilder: (BuildContext context, GoRouterState state) =>
            //     ErrorPage(state: state),
            routes: [
              GoRoute(
                path: '/',
                redirect: (BuildContext context, GoRouterState state) =>
                    '/${RoutePaths.home}',
              ),
              GoRoute(
                path: '/${RoutePaths.home}',
                routes: homeSubRoutes,
                pageBuilder: (context, state) {
                  return const MaterialPage(
                    child: HomeView(),
                  );
                },
              ),
            ],
          ),
        );
}

class ExploreNavBarItemRouter extends StatelessWidget {
  const ExploreNavBarItemRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: context.read<ExploreRouterCubit>().state.routerDelegate,
      routeInformationProvider:
          context.read<ExploreRouterCubit>().state.routeInformationProvider,
      routeInformationParser:
          context.read<ExploreRouterCubit>().state.routeInformationParser,
    );
  }
}

class ExploreRouterCubit extends Cubit<GoRouter> {
  ExploreRouterCubit()
      : super(
          GoRouter(
            initialLocation: '/${RoutePaths.explore}',
            // errorBuilder: (BuildContext context, GoRouterState state) =>
            //     ErrorPage(state: state),
            routes: [
              GoRoute(
                path: '/',
                redirect: (BuildContext context, GoRouterState state) =>
                    '/${RoutePaths.explore}',
              ),
              GoRoute(
                path: '/${RoutePaths.explore}',
                routes: exploreSubRoutes,
                pageBuilder: (context, state) {
                  return const MaterialPage(
                    child: ExploreView(),
                  );
                },
              ),
            ],
          ),
        );
}

class CartNavBarItemRouter extends StatelessWidget {
  const CartNavBarItemRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: context.read<CartRouterCubit>().state.routerDelegate,
      routeInformationProvider:
          context.read<CartRouterCubit>().state.routeInformationProvider,
      routeInformationParser:
          context.read<CartRouterCubit>().state.routeInformationParser,
    );
  }
}

class CartRouterCubit extends Cubit<GoRouter> {
  CartRouterCubit()
      : super(
          GoRouter(
            initialLocation: '/${RoutePaths.cart}',
            // errorBuilder: (BuildContext context, GoRouterState state) =>
            //     ErrorPage(state: state),
            routes: [
              GoRoute(
                path: '/',
                redirect: (BuildContext context, GoRouterState state) =>
                    '/${RoutePaths.cart}',
              ),
              GoRoute(
                path: '/${RoutePaths.cart}',
                routes: carteSubRoutes,
                pageBuilder: (context, state) {
                  return const MaterialPage(
                    child: CartView(),
                  );
                },
              ),
            ],
          ),
        );
}

class OrdersNavBarItemRouter extends StatelessWidget {
  const OrdersNavBarItemRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: context.read<OrdersRouterCubit>().state.routerDelegate,
      routeInformationProvider:
          context.read<OrdersRouterCubit>().state.routeInformationProvider,
      routeInformationParser:
          context.read<OrdersRouterCubit>().state.routeInformationParser,
    );
  }
}

class OrdersRouterCubit extends Cubit<GoRouter> {
  OrdersRouterCubit()
      : super(
          GoRouter(
            initialLocation: '/${RoutePaths.orders}',
            // errorBuilder: (BuildContext context, GoRouterState state) =>
            //     ErrorPage(state: state),
            routes: [
              GoRoute(
                path: '/',
                redirect: (BuildContext context, GoRouterState state) =>
                    '/${RoutePaths.orders}',
              ),
              GoRoute(
                path: '/${RoutePaths.orders}',
                routes: ordersSubRoutes,
                pageBuilder: (context, state) {
                  return const MaterialPage(
                    child: OrdersView(),
                  );
                },
              ),
            ],
          ),
        );
}

class AccountNavBarItemRouter extends StatelessWidget {
  const AccountNavBarItemRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: context.read<AccountRouterCubit>().state.routerDelegate,
      routeInformationProvider:
          context.read<AccountRouterCubit>().state.routeInformationProvider,
      routeInformationParser:
          context.read<AccountRouterCubit>().state.routeInformationParser,
    );
  }
}

class AccountRouterCubit extends Cubit<GoRouter> {
  AccountRouterCubit()
      : super(
          GoRouter(
            initialLocation: '/${RoutePaths.account}',
            // errorBuilder: (BuildContext context, GoRouterState state) =>
            //     ErrorPage(state: state),
            routes: [
              GoRoute(
                path: '/',
                redirect: (BuildContext context, GoRouterState state) =>
                    '/${RoutePaths.account}',
              ),
              GoRoute(
                path: '/${RoutePaths.account}',
                routes: accountSubRoutes,
                pageBuilder: (context, state) {
                  return const MaterialPage(
                    child: AccountView(),
                  );
                },
              ),
            ],
          ),
        );
}
