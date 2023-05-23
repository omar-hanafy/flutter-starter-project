import 'package:flutter/material.dart';

import '../../app.dart';

extension NavigationExtension on BuildContext {
  Future<T?> pushTo<T extends Object?>(
    RouteName routeName, {
    bool pushGlobally = false,
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) =>
      NavigationHelper(this).pushNamed(
        routeName,
        pushGlobally: pushGlobally,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );

  // NavigationHelper get navigationHelper => NavigationHelper(this);

  // NavigationBarCubit get navigationBarCubit => read<NavigationBarCubit>();
}

extension StatefulNavigationShellEx on StatefulNavigationShell {
  void goIndex(int index) {
    goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == currentIndex,
    );
  }
}
