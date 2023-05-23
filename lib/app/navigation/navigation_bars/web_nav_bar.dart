import 'package:flutter/material.dart';

import '../../../../app/app.dart';

class WebBar extends StatelessWidget {
  const WebBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.widthPx;
    debugPrint('${context.screenType} screen width: $screenWidth');

    final isMedium = context.isSmallerThan(ScreenType.lTablet);

    final isSmall = context.isSmallerThan(ScreenType.sTablet);

    final navigationItems = [
      WebNavBarItem(
        icon: const Icon(AppIcon.homeOutlined),
        routeName: RouteName.home,
        label: 'home',
        navigationShell: navigationShell,
        index: 0,
      ),
      WebNavBarItem(
        icon: const Icon(AppIcon.searchOutlined),
        routeName: RouteName.explore,
        label: 'explore',
        navigationShell: navigationShell,
        index: 1,
      ),
      WebNavBarItem(
        icon: const Icon(AppIcon.shoppingCartOutlined),
        routeName: RouteName.cart,
        label: 'cart',
        navigationShell: navigationShell,
        index: 2,
      ),
      WebNavBarItem(
        icon: const Icon(AppIcon.archiveOutlined),
        routeName: RouteName.orders,
        label: 'orders',
        navigationShell: navigationShell,
        index: 3,
      ),
      WebNavBarItem(
        icon: const Icon(AppIcon.personOutlined),
        routeName: RouteName.account,
        label: 'account',
        navigationShell: navigationShell,
        index: 4,
      ),
    ];

    final Widget changeBrightnessIcon = IconButton(
      onPressed: () => context.themeBloc.add(ChangeThemeMode(context)),
      icon: Icon(context.isDark ? AppIcon.darkMode : AppIcon.darkModeOutlined),
    );

    return isSmall
        ? Scaffold(
            drawerEnableOpenDragGesture: false,
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
            body: navigationShell,
          )
        : Scaffold(
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
                        Expanded(child: navigationShell),
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
  const WebNavBarItem({
    required this.routeName,
    required this.label,
    required this.index,
    required this.navigationShell,
    this.icon,
    super.key,
  });

  final RouteName routeName;
  final String label;
  final Icon? icon;
  final int index;
  final StatefulNavigationShell navigationShell;

  TextStyle? _getTextStyle() {
    if (index == navigationShell.currentIndex) {
      return const TextStyle(
        color: AppColors.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
    }
    return const TextStyle(fontSize: 16);
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = context.isSmallerThan(ScreenType.sTablet);
    return isSmall
        ? ListTile(
            title: Text(
              label,
              style: _getTextStyle(),
            ),
            onTap: () {
              navigationShell.goIndex(index);
              context.pop();
            },
          )
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => navigationShell.goIndex(index),
            child: FocusableActionDetector(
              mouseCursor: SystemMouseCursors.click,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    label,
                    style: _getTextStyle(),
                  ),
                ),
              ),
            ),
          );
  }
}
