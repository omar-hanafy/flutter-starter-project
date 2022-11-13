import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app.dart';

class WebNavigationBar extends StatelessWidget {
  const WebNavigationBar({super.key, required this.child});

  final Widget child;

  static TextStyle? _getTextStyle(BuildContext context,
      {RouteName routeName = RouteName.home}) {
    final firstPage = NavigationHelper(context).firstPage;
    if (firstPage == routeName.name) {
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

    final isSmall =
        AppBreakpoint.isSmallerThan(screenWidth, ScreenType.sTablet);

    final isMedium =
        AppBreakpoint.isSmallerThan(screenWidth, ScreenType.lTablet);

    Widget navBarItem({required RouteName routeName}) {
      if (isSmall) {
        return ListTile(
          title: Text(routeName.fullName,
              style: _getTextStyle(context, routeName: routeName)),
          onTap: () {
            context
              ..pushNamed(name: routeName)
              ..pop();
          },
        );
      }
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => context.pushNamed(name: routeName),
        child: FocusableActionDetector(
          mouseCursor: SystemMouseCursors.click,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(routeName.fullName,
                  style: _getTextStyle(context, routeName: routeName)),
            ),
          ),
        ),
      );
    }

    final navigationItems = <Widget>[
      navBarItem(routeName: RouteName.home),
      navBarItem(routeName: RouteName.explore),
      navBarItem(routeName: RouteName.cart),
      navBarItem(routeName: RouteName.orders),
      navBarItem(routeName: RouteName.account),
    ];

    final Widget changeBrightnessIcon = IconButton(
      onPressed: () => context.read<ThemeBloc>().add(ChangeBrightness(context)),
      icon: Icon(context.isDark ? Icons.dark_mode : Icons.dark_mode_outlined),
    );

    return isSmall
        ? Scaffold(
            drawerEnableOpenDragGesture: false,
            appBar: const CustomAppBar() as PreferredSizeWidget,
            drawer: Drawer(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                children: [
                  const AppLogo(closeDrawer: true),
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
                                if (isMedium) const AppLogo(),
                                if (isMedium)
                                  const SizedBox(width: 20)
                                else
                                  const Expanded(flex: 2, child: AppLogo()),
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
                                changeBrightnessIcon
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
