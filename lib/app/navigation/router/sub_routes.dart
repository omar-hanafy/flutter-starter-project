import 'package:go_router/go_router.dart';

// myAppRoute({String uniqueId = "",bool isSub = true}) => GoRoute(
//       path: isSub ? RoutePaths.myApp : "/${RoutePaths.myApp}",
//       name: "$uniqueId${RoutePaths.myApp}",
//       pageBuilder: (context, state) {
//         try {
//           return NoTransitionPage<void>(
//             key: state.pageKey,
//             child: MyAppView(),
//           );
//         } catch (e) {
//           return NoTransitionPage<void>(
//             key: state.pageKey,
//             child: MyAppError(error: e.toString()),
//           );
//         }
//       },
//     );

final List<RouteBase> homeSubRoutes = [
  // myAppRoute(uniqueId: "home/"),
  // contactRoute(uniqueId: "home/")
];

final List<RouteBase> exploreSubRoutes = [
  // myAppRoute(uniqueId: "works/")
];
final List<RouteBase> carteSubRoutes = [
  // myAppRoute(uniqueId: "resume/")
];
final List<RouteBase> ordersSubRoutes = [
  // myAppRoute(uniqueId: "about/"),
  // contactRoute(uniqueId: "about/")
];
final List<RouteBase> accountSubRoutes = [
  // myAppRoute(uniqueId: "about/"),
  // contactRoute(uniqueId: "about/")
];
