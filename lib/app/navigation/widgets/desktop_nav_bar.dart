import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';

class DesktopNavigationBar extends StatelessWidget {
  const DesktopNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBarCubit, NavigationBarState>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: 100,
              child: NavigationRail(
                elevation: 8,
                selectedIndex: state.index,
                groupAlignment: -1,
                selectedLabelTextStyle: const TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelTextStyle:
                    const TextStyle(color: AppColors.darkGrey, fontSize: 10),
                unselectedIconTheme:
                    const IconThemeData(color: AppColors.darkGrey),
                selectedIconTheme: const IconThemeData(color: AppColors.black),
                onDestinationSelected: (int index) {
                  if (index == state.index) {
                    // Router.neglect(context, () {
                    //   NavigatorHelper(context).pushNamed(name: 'home');
                    // });
                  } else {
                    context.navigationBarCubit.goIndex(index);
                  }
                },
                labelType: NavigationRailLabelType.all,
                // leading: widget,
                // trailing:
                destinations: context.navigationHelper.desktopNavItems,
              ),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: state.controller,
                children: NavigationHelper.navPageRouters,
              ),
            ),
          ],
        );
      },
    );
  }
}
