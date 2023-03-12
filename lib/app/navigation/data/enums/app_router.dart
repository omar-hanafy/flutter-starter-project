enum RouteName {
  home,
  explore,
  cart,
  orders,
  account,
}

extension RouteNameExtension on RouteName {
  String get navBarTitle {
    switch (this) {
      case RouteName.home:
        return 'Home';
      case RouteName.explore:
        return 'Explore';
      case RouteName.cart:
        return 'Cart';
      case RouteName.orders:
        return 'Orders';
      case RouteName.account:
        return 'Account';
    }
  }

  // String get routeName => name;

  String get routeName {
    switch (this) {
      case RouteName.home:
        return 'home';
      case RouteName.explore:
        return 'explore';
      case RouteName.cart:
        return 'cart';
      case RouteName.orders:
        return 'orders';
      case RouteName.account:
        return 'account';
    }
  }

  String get routePath => '/$routeName';
}

extension RouteStringExtension on String {
  RouteName get getRouteName {
    switch (toLowerCase()) {
      case 'home':
        return RouteName.home;
      case 'explore':
        return RouteName.explore;
      case 'cart':
        return RouteName.cart;
      case 'orders':
        return RouteName.orders;
      case 'account':
        return RouteName.account;
      default:
        return RouteName.home;
    }
  }
}

extension RouteIntExtension on int {
  RouteName get getRouteName => RouteName.values[this];
}
