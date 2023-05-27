import 'dart:convert';

import 'package:flutter_starter/app/app.dart';

abstract class RouterBaseArgs {
  static Map<String, dynamic>? toMap(GoRouterState state) {
    if (state.queryParameters.isEmptyOrNull &&
        state.pathParameters.isEmptyOrNull) {
      return null;
    }
    final params = json.decode(
      (state.queryParameters.isNotEmptyOrNull
          ? state.queryParameters['params']
          : state.pathParameters['params'])!,
    );
    return ConvertObject.toMap(params);
  }

  Map<String, dynamic> toJson();

  Map<String, String> toQueryParams() {
    return {
      'params': json.encode(toJson()),
    };
  }

  @override
  String toString() {
    return '${toQueryParams()}';
  }
}
