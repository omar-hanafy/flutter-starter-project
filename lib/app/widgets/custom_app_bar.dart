import 'package:flutter/cupertino.dart';

class CustomAppBar extends PreferredSize {
  CustomAppBar({
    super.key,
    required this.args,
  }) : super(
          child: CustomAppBarWidget(args: args),
          preferredSize: args.preferredSize,
        );

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
  const AppBarArgs({
    required this.preferredSize,
  });

  final Size preferredSize;
}
