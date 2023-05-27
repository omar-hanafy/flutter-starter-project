import 'package:flutter/material.dart';

import '../../../app/app.dart';

class FeatureViewArgs extends RouterBaseArgs {
  FeatureViewArgs(this.id);

  static FeatureViewArgs? _fromJson(Map<String, dynamic>? map) =>
      map == null ? null : FeatureViewArgs(ConvertObject.toInt(map['id']));

  static FeatureViewArgs? fromState(GoRouterState state) =>
      _fromJson(RouterBaseArgs.toMap(state));

  final int id;

  @override
  Map<String, dynamic> toJson() => {'id': id};
}

class FeatureView extends StatefulWidget {
  const FeatureView({required this.params, super.key});

  final FeatureViewArgs? params;

  @override
  State<FeatureView> createState() => _FeatureViewState();
}

class _FeatureViewState extends State<FeatureView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Feature', style: context.txtTheme.displayLarge),
      ),
    );
  }
}
