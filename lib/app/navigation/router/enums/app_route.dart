import 'package:flutter_starter/lib.dart';

enum AppRoute {
  home(isBranch: true, branchKey: '_homeRouter'),
  explore(isBranch: true, branchIndex: 1, branchKey: '_exploreRouter'),
  cart(isBranch: true, branchIndex: 2, branchKey: '_cartRouter'),
  orders(isBranch: true, branchIndex: 3, branchKey: '_ordersRouter'),
  account(isBranch: true, branchIndex: 4, branchKey: '_accountRouter'),
  feature(isGlobalOnly: false),
  notFound();

  const AppRoute({
    this.isBranch = false,
    this.isGlobalOnly = false,
    this.branchIndex = 0,
    this.branchKey,
  }) : assert((isBranch && branchKey != null) || !isBranch,
            'All Route Branches Must Have a Unique Key');

  /// tells if this route is a branch in the navigation bar or not.
  final bool isBranch;

  /// ability to force the route to be pushed globally only.
  /// global means that the pushed screen will be on top of the navigation bar
  /// and will ignore the [StatefulNavigationShell].
  final bool isGlobalOnly;

  /// the index of the branch in the navigation bar
  /// and it should be given only when [isBranch] is set to true.
  final int branchIndex;

  /// a unique key that is given to
  /// each branch in the [StatefulNavigationShell].
  final String? branchKey;

  /// getter that represents the main branch
  static AppRoute get main => AppRoute.home;

  /// adds a key to route name to generate the unique name
  /// for sub route to navigate to it.
  String nameWithKey(String key) => '$key/$name';

  /// generates a path to each route.
  String get routePath => '/$name';
}

extension AppRouteStringExtension on String? {
  AppRoute get appRoute {
    if (isEmptyOrNull) {
      return AppRoute.notFound;
    } else {
      final s = this?.toCamelCase;
      for (final route in AppRoute.values) {
        if (s == route.name) return route;
      }
    }
    return AppRoute.notFound;
  }
}
