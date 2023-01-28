import 'package:flutter/material.dart';

import '../../app.dart';

extension NavigationExtension on BuildContext {
  void pushNamed(
          {bool pushGlobally = false,
          required RouteName name,
          Map<String, String> queryParams = const {}}) =>
      NavigationHelper(this).pushNamed(
          name: name, pushGlobally: pushGlobally, queryParams: queryParams);

  List<WebNavBarItem> get webNavItems => NavigationHelper(this).webNavItems;
}
