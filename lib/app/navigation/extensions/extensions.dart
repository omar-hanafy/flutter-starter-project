import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';

extension NavigationExtension on BuildContext {
  void pushNamed(
          {bool pushGlobally = false,
          required RouteName name,
          Map<String, String> queryParams = const {}}) =>
      NavigationHelper(this).pushNamed(
          routeName: name,
          pushGlobally: pushGlobally,
          queryParams: queryParams);

  NavigationHelper get navigationHelper => NavigationHelper(this);

  NavigationBarCubit get navigationBarCubit => read<NavigationBarCubit>();
}
