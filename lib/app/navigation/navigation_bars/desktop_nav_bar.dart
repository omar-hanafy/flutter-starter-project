import 'package:flutter/material.dart';

import '../../../app/app.dart';

class DesktopNavigationBar extends StatelessWidget {
  const DesktopNavigationBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: NavigationRail(
            elevation: 8,
            selectedIndex: navigationShell.currentIndex,
            groupAlignment: -1,
            selectedLabelTextStyle: const TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelTextStyle:
                const TextStyle(color: AppColors.darkGrey, fontSize: 10),
            unselectedIconTheme: const IconThemeData(color: AppColors.darkGrey),
            selectedIconTheme: const IconThemeData(color: AppColors.black),
            onDestinationSelected: navigationShell.goIndex,
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(AppIcon.homeOutlined),
                label: Text(
                  'home',
                ),
              ),
              NavigationRailDestination(
                icon: Icon(AppIcon.searchOutlined),
                label: Text(
                  'explore',
                ),
              ),
              NavigationRailDestination(
                icon: Icon(AppIcon.shoppingCartOutlined),
                label: Text(
                  'cart',
                ),
              ),
              NavigationRailDestination(
                icon: Icon(AppIcon.archiveOutlined),
                label: Text(
                  'orders',
                ),
              ),
              NavigationRailDestination(
                icon: Icon(AppIcon.personOutlined),
                label: Text(
                  'account',
                ),
              ),
            ],
          ),
        ),
        Expanded(child: navigationShell),
      ],
    );
  }
}
