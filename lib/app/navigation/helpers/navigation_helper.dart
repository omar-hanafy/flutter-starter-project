import 'package:flutter/material.dart';

import '../../../lib.dart';

class NavigationHelper {
  NavigationHelper(this.context);

  final BuildContext context;

  Future<T?> pushNamed<T extends Object?>(
    RouteName routeName, {
    bool pushGlobally = false,
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) async {
    return GoRouter.of(context).pushNamed<T>(
      routeName.name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void pushReplacement(
    RouteName routeName, {
    bool pushGlobally = false,
    Map<String, String> queryParams = const {},
  }) {
    GoRouter.of(context).pushReplacementNamed(
      routeName.name,
      pathParameters: queryParams,
    );
  }
}
