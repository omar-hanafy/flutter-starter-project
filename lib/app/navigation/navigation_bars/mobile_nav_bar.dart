import 'package:flutter/material.dart';
import 'package:flutter_starter/lib.dart';

class MobileNavigationBar extends StatelessWidget {
  const MobileNavigationBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: navigationShell.goIndex,
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.darkGrey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedFontSize: 16,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryColor,
            icon: Icon(AppIcon.homeOutlined),
            label: 'home',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryColor,
            icon: Icon(AppIcon.searchOutlined),
            label: 'explore',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryColor,
            icon: Icon(AppIcon.shoppingCartOutlined),
            label: 'cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryColor,
            icon: Icon(AppIcon.archiveOutlined),
            label: 'orders',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryColor,
            icon: Icon(AppIcon.personOutlined),
            label: 'account',
          ),
        ],
      ),
    );
  }
}
