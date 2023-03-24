import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../lib.dart';

part 'navigation_bar_state.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit()
      : super(NavigationBarState(controller: PageController(), index: 0));

  void goIndex(int index) {
    if (state.controller.hasClients) {
      state.controller.jumpToPage(index);
      emit(
        NavigationBarState(index: index, controller: state.controller),
      );
    }
  }

  void goName(RouteName name) {
    if (state.controller.hasClients &&
        NavigationHelper.navPageRouters.length < name.index) {
      state.controller.jumpToPage(name.index);
      emit(
        NavigationBarState(index: name.index, controller: state.controller),
      );
    }
  }
}
