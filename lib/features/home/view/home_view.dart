import 'package:flutter/material.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

import '../../../lib.dart';

//
// class HomeView extends StatefulWidget {
//   const HomeView({super.key});
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Scaffold(
//       body: Center(
//         child: Text('Home', style: context.txtTheme.displayLarge),
//       ),
//     );
//   }
// }

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<void> _onScrollsToTop(ScrollsToTopEvent event) async {
    debugPrint('Scroll to top!');
    await scrollController.animateTo(
      event.to,
      duration: event.duration,
      curve: event.curve,
    );
  }

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ScrollsToTop(
      onScrollsToTop: _onScrollsToTop,
      child: Scaffold(
        appBar: CustomAppBar(
          preferredSize: context.sizePx,
          args: const AppBarArgs(),
        ),
        body: ListView.builder(
          controller: scrollController,
          itemCount: 10,
          itemBuilder: (_, __) => const SizedBox(
            height: 400,
            child: Card(),
          ),
        ),
      ),
    );
  }
}
