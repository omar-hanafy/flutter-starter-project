import 'package:flutter/material.dart';

import '../app.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(NavigationHelper(context).getTitle),
    );
  }
}
