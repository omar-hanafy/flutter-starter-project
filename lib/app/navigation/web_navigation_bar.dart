import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../app.dart';

class WebNavigationBar extends StatelessWidget {
  const WebNavigationBar({super.key, required this.child});

  final Widget child;

  static TextStyle? _getTextStyle(BuildContext context,
      {String routeName = RoutePaths.home}) {
    final location = GoRouter.of(context).location;
    if (location.startsWith('/$routeName')) {
      return const TextStyle(
          color: AppColor.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold);
    }
    return const TextStyle(fontSize: 16);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.widthPx;
    debugPrint(
        '${AppBreakpoint.getScreenType(context)} screen width: $screenWidth');

    // debugPrint(GoRouter.of(context).toString());
    final isSmall =
        AppBreakpoint.isSmallerThan(screenWidth, ScreenType.sTablet);

    final isMedium =
        AppBreakpoint.isSmallerThan(screenWidth, ScreenType.lTablet);
    //
    // final bool isMobile =
    //     ResponsiveWrapper.of(context).isSmallerThan("L MOBILE");
    // final bool isTablet = ResponsiveWrapper.of(context).isSmallerThan(TABLET);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget navBarItem({required String title, required String path}) {
      if (isSmall) {
        return ListTile(
          title: Text(title, style: _getTextStyle(context, routeName: path)),
          onTap: () {
            context.go('/$path');
            Navigator.pop(context);
          },
        );
      }
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => context.go('/$path'),
        child: FocusableActionDetector(
          mouseCursor: SystemMouseCursors.click,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child:
                  Text(title, style: _getTextStyle(context, routeName: path)),
            ),
          ),
        ),
      );
    }

    final navigationItems = <Widget>[
      navBarItem(title: 'Home', path: RoutePaths.home),
      navBarItem(title: 'Explore', path: RoutePaths.explore),
      navBarItem(title: 'Cart', path: RoutePaths.cart),
      navBarItem(title: 'Orders', path: RoutePaths.orders),
      navBarItem(title: 'Account', path: RoutePaths.account),
    ];

    final Widget myLogo = GestureDetector(
      onTap: () {
        context.go('/${RoutePaths.home}');
        if (isSmall) Navigator.pop(context);
      },
      child: Text(
        'App Logo',
        style: context.textTheme.headline6!.copyWith(
          fontWeight: FontWeight.w900,
        ),
      ),
    );

    final Widget brightnessChange = IconButton(
      onPressed: () => context.read<ThemeBloc>().add(ChangeBrightness(context)),
      icon: Icon(isDark ? Icons.dark_mode : Icons.dark_mode_outlined),
    );
    return isSmall
        ? Scaffold(
            drawerEnableOpenDragGesture: false,
            appBar: AppBar(
              elevation: 0,
              title: Text(RoutePaths.getTitle(context)),
              actions: [brightnessChange],
            ),
            drawer: Drawer(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                children: [
                  myLogo,
                  const SizedBox(height: 30),
                  ...navigationItems
                ],
              ),
            ),
            body: child,
          )
        : Scaffold(
            drawerEnableOpenDragGesture: false,
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1300,
                      minWidth: 450,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                if (isMedium) myLogo,
                                if (isMedium)
                                  const SizedBox(width: 20)
                                else
                                  Expanded(flex: 2, child: myLogo),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: isMedium
                                        ? MainAxisAlignment.spaceEvenly
                                        : MainAxisAlignment.spaceBetween,
                                    children: navigationItems,
                                  ),
                                ),
                                if (isMedium)
                                  const SizedBox(width: 20)
                                else
                                  const Expanded(child: SizedBox()),
                                brightnessChange
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: child),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
