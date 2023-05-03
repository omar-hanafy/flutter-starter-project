import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  NavigationHelper get navigationHelper => NavigationHelper(this);

  NavigationBarCubit get navigationBarCubit => read<NavigationBarCubit>();
}
