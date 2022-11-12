import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

import 'lib.dart';

void main() => bootstrap(() => const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Project Title',
      // onGenerateTitle: (BuildContext context) => ' Project Localized Title',
      routerConfig: context.read<AppRouterCubit>().state,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
