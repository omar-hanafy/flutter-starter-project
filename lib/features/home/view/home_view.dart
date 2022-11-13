import 'package:flutter/material.dart';

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
//         child: Text('Home', style: context.textTheme.headline1),
//       ),
//     );
//   }
// }
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: ListView.builder(
      itemCount: 10,
      itemBuilder: (_, __) => const SizedBox(
        height: 400,
        child: Card(),
      ),
    ));
  }
}
