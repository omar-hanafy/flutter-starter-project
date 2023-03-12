import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  FlutterError.onError = (FlutterErrorDetails details) {
    log(
      '''
    exceptionAsString: ${details.exceptionAsString()},
    library: ${details.library},
    context: ${details.context},
    exception: ${details.exception},
    silent: ${details.silent},
    informationCollector: ${details.informationCollector},
    stackFilter: ${details.stackFilter}
    stacktrace:
    ''',
      stackTrace: details.stack,
    );
  };

  WidgetsFlutterBinding.ensureInitialized();

  // modify and manage app window on desktop platforms
  if (defaultTargetPlatform.isDesktop) {
    await windowManager.ensureInitialized();
    const windowOptions = WindowOptions();

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setMinimumSize(const Size(500, 500));
      await windowManager.focus();
    });
  }

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
          BlocProvider(
            create: (_) => ThemeBloc(),
          ),
          BlocProvider(
            create: (_) => InternetConnectionBloc()..add(CheckConnection()),
          ),
          if (!kIsWeb) BlocProvider(create: (_) => NavigationBarCubit()),
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

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }

  @override
  void onError(
    BlocBase<dynamic> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    log(error.toString());
    super.onError(bloc, error, stackTrace);
  }
}
