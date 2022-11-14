import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';

class MobileNavigationBar extends StatelessWidget {
  const MobileNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBarCubit, NavigationBarState>(
      builder: (context, state) {
        return Scaffold(
            body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: state.controller,
                children: NavigationHelper.navWidgets),
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
