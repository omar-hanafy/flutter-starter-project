import 'package:flutter/material.dart';

import '../../lib.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.closeDrawer = false});

  final bool closeDrawer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushTo(RouteName.home);
        if (closeDrawer) context.pop();
      },
      child: Text(
        'App Logo',
        style: context.textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
