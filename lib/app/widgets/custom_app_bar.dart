import 'package:flutter/cupertino.dart';

class CustomAppBar extends PreferredSize {
  CustomAppBar({
    super.key,
    required this.args,
    required super.preferredSize,
  }) : super(child: CustomAppBarWidget(args: args));

  final AppBarArgs args;
}

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({super.key, required this.args});

  final AppBarArgs args;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
    );
  }
}

class AppBarArgs {
  const AppBarArgs();
}
