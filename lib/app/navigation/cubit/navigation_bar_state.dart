part of 'navigation_bar_cubit.dart';

class NavigationBarState {
  NavigationBarState({required this.controller, required this.index});

  final PageController controller;
  final int index;

  NavigationBarState copyWith({
    PageController? controller,
    int? index,
  }) {
    return NavigationBarState(
      controller: controller ?? this.controller,
      index: index ?? this.index,
    );
  }
}
