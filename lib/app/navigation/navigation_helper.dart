import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class NavigationHelper {
  //todo: create extension methods

  NavigationHelper(this.context);

  final BuildContext context;

  List<String> get pages {
    var location = GoRouter.of(context).location;
    if (location.startsWith('/')) {
      location = location.substring(1);
    }
    return location.split('?').first.split('/');
  }

  Map<String, String> get arguments {
    final argsMap = <String, String>{};
    final location = GoRouter.of(context).location;
    if (location.contains('?')) {
      final argsList = location.split('?').last.split('&');
      for (final element in argsList) {
        if (element.contains('=')) {
          final list = element.split('=');
          argsMap[list.first] = list.last;
        }
      }
    }
    return argsMap;
  }

  String get lastPage => pages.last;

  String get firstPage => pages.first;
}
