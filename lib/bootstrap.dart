import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

import 'lib.dart';

///  Future<void> bootstrap(FutureOr<Widget> Function() builder) async
///    is defining a function called bootstrap. This function takes a
///    parameter called builder that is a function taking no parameters
///    returning a Future or a Widget and it will
///    execute asynchronously (builder may or may not execute asynchronously).
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions();

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setMinimumSize(const Size(500, 500));
    await windowManager.focus();
  });

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());

  ///    The Bloc.observer = AppBlocObserver();
  ///    is a deprecated way of observing what the bloc(s) of the application
  ///    are doing. The AppBlocObserver is defining a bunch of callbacks that
  ///    will be executed when "events" are fired, like error, and change.
  Bloc.observer = AppBlocObserver();

  // AuthenticationRepository authRepository;
  // await Firebase.initializeApp(
  //     // todo: generate your firebase Options.
  //     // options: DefaultFirebaseOptions.currentPlatform,
  //     );

  // authRepository = AuthenticationRepository();
  // await authRepository.user.first;

  await runZonedGuarded(
    () async => runApp(
      MultiBlocProvider(
        providers: [
          // BlocProvider<NavigationIndexCubit>(
          //     create: (context) => NavigationIndexCubit()),
          // BlocProvider<NavigationControllerCubit>(
          //     create: (context) => NavigationControllerCubit()),
          BlocProvider(create: (_) => AppRouterCubit()),
          BlocProvider(create: (_) => ThemeBloc()),
          BlocProvider(
              create: (_) => InternetConnectionBloc()..add(CheckConnection())),
          // BlocProvider(
          //     create: (_) => AppBloc(authenticationRepository: authRepository)),
          //todo: merge navigation blocs
        ],
        child: await builder(),
      ),
    ),

    ///    That app is then going to be run in an error zone, where the
    ///    interesting part is:
    ///    The onError function is used both to handle asynchronous errors by
    ///    overriding ZoneSpecification.handleUncaughtError in zoneSpecification,
    ///    if any, and to handle errors thrown synchronously by the call to body.
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
