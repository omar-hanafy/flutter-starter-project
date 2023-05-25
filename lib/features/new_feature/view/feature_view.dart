import 'package:flutter/material.dart';

import '../../../app/app.dart';

class FeatureView extends StatefulWidget {
  const FeatureView({required this.params, super.key});

  final Object? params;

  @override
  State<FeatureView> createState() => _FeatureViewState();
}

class _FeatureViewState extends State<FeatureView> {
  @override
  Widget build(BuildContext context) {
    debugPrint('${widget.params}');
    return Scaffold(
      body: Center(
        child: Text('Feature', style: context.txtTheme.displayLarge),
      ),
    );
  }
}
