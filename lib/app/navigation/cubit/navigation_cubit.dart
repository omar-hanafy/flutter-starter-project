import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../lib.dart';

extension NavigationCubitEx on BuildContext {
  NavigationCubit get navigationCubit => read<NavigationCubit>();

  NavigationCubit get navigationCubitWatch => watch<NavigationCubit>();
}

class NavigationCubit extends Cubit<StatefulNavigationShell> {
  NavigationCubit(this.navigationShell) : super(navigationShell);
  final StatefulNavigationShell navigationShell;

  void reBuild(StatefulNavigationShell shell) => emit(shell);

  void goIndex(int index) => state.goIndex(index);

  int get index => state.currentIndex;

  AppRoute get appRoute => AppRoute.values[index];
}
