import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app.dart';

Widget _pageView(PageController controller) => PageView(
    physics: const NeverScrollableScrollPhysics(),
    controller: controller,
    children: NavigationHelper.navWidgets);
/*
title icon widget router
*/
class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NavigationBarCubit>().init();
    return BlocBuilder<NavigationBarCubit, NavigationBarState>(
      builder: (context, state) {
        return Scaffold(
            body: _pageView(state.controller),
            appBar: AppBar(
                elevation: 0, title: Text(NavigationHelper(context).getTitle)),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.index,
              // selectedItemColor: AppColor.selectedItemsColor,
              // unselectedItemColor: AppColor.unSelectedItemsColor,
              onTap: (int index) {
                if (index == state.index) {
                  // Router.neglect(context, () {
                  //   NavigatorHelper(context).pushNamed(name: 'home');
                  // });
                } else {
                  context.read<NavigationBarCubit>().goIndex(index);
                }
              },
              selectedItemColor: AppColor.black,
              unselectedItemColor: AppColor.darkGrey,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              selectedFontSize: 16,
              unselectedFontSize: 10,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  backgroundColor: AppColor.primaryColor,
                  icon: const Icon(Icons.home_outlined),
                  label: AppLocalizations.of(context)!.home,
                ),
                BottomNavigationBarItem(
                  backgroundColor: AppColor.primaryColor,
                  icon: const Icon(Icons.search_outlined),
                  label: AppLocalizations.of(context)!.explore,
                ),
                BottomNavigationBarItem(
                  backgroundColor: AppColor.primaryColor,
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: AppLocalizations.of(context)!.cart,
                ),
                BottomNavigationBarItem(
                  backgroundColor: AppColor.primaryColor,
                  icon: const Icon(Icons.archive_outlined),
                  label: AppLocalizations.of(context)!.orders,
                ),
                BottomNavigationBarItem(
                  backgroundColor: AppColor.primaryColor,
                  icon: const Icon(Icons.person_outlined),
                  label: AppLocalizations.of(context)!.account,
                ),
              ],
            ));
      },
    );
  }
}

class MyNavigationRail extends StatelessWidget {
  const MyNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NavigationBarCubit>().init();
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
            Expanded(child: _pageView(state.controller)),
          ],
        );
      },
    );
  }
}
