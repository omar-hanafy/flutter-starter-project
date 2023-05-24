import 'package:flutter/material.dart';

import '../../../../app/app.dart';

class WebBar extends StatelessWidget {
  const WebBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.widthPx;
    debugPrint('${context.screenType} screen width: $screenWidth');
    final isMedium = context.isSmallerThan(ScreenType.lTablet);
    final isSmall = context.isSmallerThan(ScreenType.sTablet);
    final navigationShell = context.navigationCubitWatch.state;

    final navigationItems = [
      const WebNavBarItem(
        icon: Icon(AppIcon.homeOutlined),
        route: AppRoute.home,
        label: 'home',
      ),
      const WebNavBarItem(
        icon: Icon(AppIcon.searchOutlined),
        route: AppRoute.explore,
        label: 'explore',
      ),
      const WebNavBarItem(
        icon: Icon(AppIcon.shoppingCartOutlined),
        route: AppRoute.cart,
        label: 'cart',
      ),
      const WebNavBarItem(
        icon: Icon(AppIcon.archiveOutlined),
        route: AppRoute.orders,
        label: 'orders',
      ),
      const WebNavBarItem(
        icon: Icon(AppIcon.personOutlined),
        route: AppRoute.account,
        label: 'account',
      ),
    ];

    final Widget changeBrightnessIcon = IconButton(
      onPressed: () => context.themeBloc.add(ChangeThemeMode(context)),
      icon: Icon(context.isDark ? AppIcon.darkMode : AppIcon.darkModeOutlined),
    );

    return isSmall
        ? Scaffold(
            drawerEnableOpenDragGesture: false,
            appBar: AppBar(),
            drawer: Drawer(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                children: [
                  const AppLogo(inDrawer: true),
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
    required this.route,
    required this.label,
    this.icon,
    super.key,
  });

  final AppRoute route;
  final String label;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    final isSmall = context.isSmallerThan(ScreenType.sTablet);
    final cubit = context.navigationCubitWatch;
    final textStyle = route.branchIndex == cubit.index
        ? TextStyle(
            color: context.themeData.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        : const TextStyle(fontSize: 16);

    return isSmall
        ? ListTile(
            title: Text(
              label,
              style: textStyle,
            ),
            onTap: () {
              cubit.goIndex(route.branchIndex);
              context.pop();
            },
          )
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => cubit.goIndex(route.branchIndex),
            child: FocusableActionDetector(
              mouseCursor: SystemMouseCursors.click,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    label,
                    style: textStyle,
                  ),
                ),
              ),
            ),
          );
  }
}
