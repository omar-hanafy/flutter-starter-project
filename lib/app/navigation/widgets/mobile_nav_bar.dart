import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';

class MobileNavigationBar extends StatelessWidget {
  const MobileNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationHelper = context.navigationHelper;
    return BlocBuilder<NavigationBarCubit, NavigationBarState>(
      builder: (context, state) {
        return Scaffold(
          // we can use IndexedStack
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: state.controller,
            children: NavigationHelper.navPageRouters,
          ),
          appBar: AppBar(
            elevation: 0,
            title: Text(
              navigationHelper.navBarTitle,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.index,
            // selectedItemColor: AppColors.selectedItemsColor,
            // unselectedItemColor: AppColors.unSelectedItemsColor,
            onTap: (int index) {
              if (index == state.index) {
                // do stuff when user tab the current index
              } else {
                context.navigationBarCubit.goIndex(index);
              }
            },
            selectedItemColor: AppColors.black,
            unselectedItemColor: AppColors.darkGrey,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            selectedFontSize: 16,
            unselectedFontSize: 10,
            items: navigationHelper.mobileNavItems,
          ),
        );
      },
    );
  }
}
