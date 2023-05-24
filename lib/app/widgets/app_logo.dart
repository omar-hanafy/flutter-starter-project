import 'package:flutter/material.dart';

import '../../lib.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.inDrawer = false});

  final bool inDrawer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goPush(AppRoute.feature);
        if (inDrawer) context.pop();
      },
      child: Text(
        'App Logo',
        style: context.txtTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
