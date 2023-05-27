import 'package:flutter/material.dart';
import 'package:flutter_starter/features/new_feature/feature.dart';

import '../../lib.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.inDrawer = false});

  final bool inDrawer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goPush(AppRoute.feature, args: FeatureViewArgs(3));
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
