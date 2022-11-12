import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app.dart';

class NavigationIndexCubit extends Cubit<int> {
  NavigationIndexCubit({int? optionalStartingIndex})
      : super(optionalStartingIndex ?? 0);

  void changePage(int index) => emit(index);

  void changePageByName() {}
}

class NavigationControllerCubit extends Cubit<PageController> {
  NavigationControllerCubit() : super(PageController());
}

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  static const bool showTrailing = true;
  static const double groupAlignment = -1;

  @override
  Widget build(BuildContext context) {
    final isDesktop =
        AppBreakpoint.isLargerThan(context.widthPx, ScreenType.tablet);

    final pageView = PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: context.read<NavigationControllerCubit>().state,
      onPageChanged: (int index) =>
          context.read<NavigationIndexCubit>().changePage(index),
      children: const <Widget>[
        HomeNavBarItemRouter(),
        ExploreNavBarItemRouter(),
        CartNavBarItemRouter(),
        OrdersNavBarItemRouter(),
        AccountNavBarItemRouter(),
      ],
    );

    Widget navigationRail(int selectedIndex) => SizedBox(
          width: 100,
          child: NavigationRail(
            selectedIndex: selectedIndex,
            groupAlignment: groupAlignment,
            selectedLabelTextStyle: const TextStyle(
                color: AppColor.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            unselectedLabelTextStyle:
                const TextStyle(color: AppColor.darkGrey, fontSize: 10),
            unselectedIconTheme: const IconThemeData(color: AppColor.darkGrey),
            selectedIconTheme: const IconThemeData(color: AppColor.black),
            onDestinationSelected: (int index) {
              if (index == selectedIndex) {
                // Router.neglect(context, () {
                //   NavigatorHelper(context).pushNamed(name: 'home');
                // });
              } else {
                context
                    .read<NavigationControllerCubit>()
                    .state
                    .jumpToPage(index);
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
        );

    Widget bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
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
          currentIndex: selectedIndex,
          // selectedItemColor: AppColor.selectedItemsColor,
          // unselectedItemColor: AppColor.unSelectedItemsColor,
          onTap: (int index) {
            if (index == selectedIndex) {
              // Router.neglect(context, () {
              //   NavigatorHelper(context).pushNamed(name: 'home');
              // });
            } else {
              context.read<NavigationControllerCubit>().state.jumpToPage(index);
            }
          },
        );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeRouterCubit()),
        BlocProvider(create: (context) => ExploreRouterCubit()),
        BlocProvider(create: (context) => CartRouterCubit()),
        BlocProvider(create: (context) => OrdersRouterCubit()),
        BlocProvider(create: (context) => AccountRouterCubit()),
      ],
      child: BlocBuilder<NavigationIndexCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
              body: isDesktop
                  ? Row(children: [
                      navigationRail(selectedIndex),
                      Expanded(child: pageView)
                    ])
                  : pageView,
              bottomNavigationBar:
                  isDesktop ? null : bottomNavigationBar(selectedIndex));
        },
      ),
    );
  }
}
