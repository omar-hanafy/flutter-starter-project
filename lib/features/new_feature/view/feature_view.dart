import 'package:flutter/material.dart';

import '../../../app/app.dart';

class FeatureView extends StatefulWidget {
  const FeatureView({super.key});

  @override
  State<FeatureView> createState() => _FeatureViewState();
}

class _FeatureViewState extends State<FeatureView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Feature', style: context.txtTheme.displayLarge),
      ),
    );
  }
}
