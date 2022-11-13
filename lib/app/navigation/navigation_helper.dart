import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../lib.dart';

extension NavigationHelperExtension on BuildContext {
  void pushNamed(
          {bool pushGlobally = false,
          required RouteName name,
          Map<String, String> queryParams = const {}}) =>
      NavigationHelper(this).pushNamed(
          name: name, pushGlobally: pushGlobally, queryParams: queryParams);
}

class NavigationHelper {
  //todo: create extension methods

  NavigationHelper(this.context);

  final BuildContext context;

  late final navCubit = context.read<NavigationBarCubit>();
  late final appRouterCubit = context.read<AppRouterCubit>();

  static List<Widget> get navWidgets => const [
        HomeNavBarItemRouter(),
        ExploreNavBarItemRouter(),
        CartNavBarItemRouter(),
        OrdersNavBarItemRouter(),
        AccountNavBarItemRouter(),
      ];

  List<String> get pages {
    var location = _getState.location;
    if (location == '/') {
      return kIsWeb ? ['home'] : [navCubit.state.index.getRouteName.name];
    } else if (location.startsWith('/')) {
      location = location.substring(1);
    }
    return location.split('?').first.split('/');
  }

  String get lastPage => pages.last;

  String get firstPage => pages.first;

  Map<String, String> get arguments {
    final argsMap = <String, String>{};
    final location = _getState.location;
    if (location.contains('?')) {
      final argsList = location.split('?').last.split('&');
      for (final element in argsList) {
        if (element.contains('=')) {
          final list = element.split('=');
          argsMap[list.first] = list.last;
        }
      }
    }
    return argsMap;
  }

  String get getTitle => lastPage.getRouteName.fullName;

  void pushNamed(
      {bool pushGlobally = false,
      required RouteName name,
      Map<String, String> queryParams = const {}}) {
    if (kIsWeb || pushGlobally) {
      appRouterCubit.state.goNamed(name.name, queryParams: queryParams);
    } else {
      if (NavigationHelper.navWidgets.length <= name.index) {
        navCubit.goName(name);
      } else {
        _getState.pushNamed(name.name, queryParams: queryParams);
      }
    }
  }

  GoRouter get _getState {
    if (kIsWeb) {
      return appRouterCubit.state;
    } else {
      switch (navCubit.state.index) {
        case 0:
          return context.read<HomeRouterCubit>().state;
        case 1:
          return context.read<ExploreRouterCubit>().state;
        case 2:
          return context.read<CartRouterCubit>().state;
        case 3:
          return context.read<OrdersRouterCubit>().state;
        case 4:
          return context.read<AccountRouterCubit>().state;
        default:
          return context.read<AppRouterCubit>().state;
      }
    }
  }

  void pushReplacement(
      {required RouteName name, Map<String, String> queryParams = const {}}) {}
}
