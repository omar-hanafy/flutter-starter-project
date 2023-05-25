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
            'All Route Branches Must Have Unique Key');

  final bool isBranch;
  final bool isGlobalOnly;
  final int branchIndex;
  final String? branchKey;

  String nameWithKey(String key) => '$key/$name';

  String get routePath => '/$name';
}

extension AppRouteStringExtension on String? {
  AppRoute get appRoute {
    if (isEmptyOrNull) {
      return AppRoute.notFound;
    } else {
      for (final route in AppRoute.values) {
        if (this?.toCamelCase == route.name) return route;
      }
    }
    return AppRoute.notFound;
  }
}
