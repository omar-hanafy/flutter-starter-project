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
                    color: AppColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                unselectedLabelTextStyle:
                    const TextStyle(color: AppColor.darkGrey, fontSize: 10),
                unselectedIconTheme:
                    const IconThemeData(color: AppColor.darkGrey),
                selectedIconTheme: const IconThemeData(color: AppColor.black),
                onDestinationSelected: (int index) {
                  if (index == state.index) {
                    // Router.neglect(context, () {
                    //   NavigatorHelper(context).pushNamed(name: 'home');
                    // });
                  } else {
                    context.read<NavigationBarCubit>().goIndex(index);
                  }
                },
                labelType: NavigationRailLabelType.all,
                // leading: widget,
                // trailing:
                destinations: const <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.search_outlined),
                    label: Text('Explore'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: Text('Cart'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.archive_outlined),
                    label: Text('Orders'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outlined),
                    label: Text('Account'),
                  ),
                ],
              ),
            ),
            Expanded(
                child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: state.controller,
                    children: NavigationHelper.navWidgets)),
          ],
        );
      },
    );
  }
}
