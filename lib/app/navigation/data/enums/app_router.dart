enum RouteName {
  home,
  explore,
  cart,
  orders,
  account,
  login,
}

extension RouteNameExtension on RouteName {
  String get fullName {
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
      case RouteName.login:
        return 'Login';
    }
  }

  String get path => '/$name';
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
      case 'login':
        return RouteName.login;
      default:
        return RouteName.home;
    }
  }
}

extension RouteIntExtension on int {
  RouteName get getRouteName => RouteName.values[this];
}
