import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';

class WebNavigationBar extends StatelessWidget {
  const WebNavigationBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.widthPx;
    debugPrint(
        '${AppBreakpoint.getScreenType(context)} screen width: $screenWidth');

    final isMedium =
        AppBreakpoint.isSmallerThan(screenWidth, ScreenType.lTablet);

    final isSmall =
        AppBreakpoint.isSmallerThan(screenWidth, ScreenType.sTablet);

    final navigationItems = NavigationHelper(context).webNavItems;

    final Widget changeBrightnessIcon = IconButton(
      onPressed: () => context.read<ThemeBloc>().add(ChangeBrightness(context)),
      icon: Icon(context.isDark ? AppIcon.darkMode : AppIcon.darkModeOutlined),
    );

    return isSmall
        ? Scaffold(
            drawerEnableOpenDragGesture: false,
            appBar: AppBar(
              elevation: 0,
              title: Text(NavigationHelper(context).getTitle),
              actions: [changeBrightnessIcon],
            ),
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

class WebNavBarItem extends StatelessWidget {
  const WebNavBarItem(
      {super.key, required this.routeName, this.icon, required this.label});

  final RouteName routeName;
  final String label;
  final Icon? icon;

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
    final isSmall =
        AppBreakpoint.isSmallerThan(context.widthPx, ScreenType.sTablet);
    return isSmall
        ? ListTile(
            title: Text(label,
                style: _getTextStyle(context, routeName: routeName)),
            onTap: () {
              context
                ..pushNamed(name: routeName)
                ..pop();
            },
          )
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => context.pushNamed(name: routeName),
            child: FocusableActionDetector(
              mouseCursor: SystemMouseCursors.click,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(label,
                      style: _getTextStyle(context, routeName: routeName)),
                ),
              ),
            ),
          );
  }
}
