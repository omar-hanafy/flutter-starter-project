import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lib.dart';

void main() => bootstrap(() => const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isIOS
        ? CupertinoApp.router(
            title: 'Project Title',
            // onGenerateTitle: (BuildContext context) => ' Project Localized Title',
            routerConfig: AppRouter.router,
            supportedLocales: AppLocalizations.supportedLocales,
          )
        : MaterialApp.router(
            title: 'Project Title',
            // onGenerateTitle: (BuildContext context) => ' Project Localized Title',
            routerConfig: AppRouter.router,
            supportedLocales: AppLocalizations.supportedLocales,
          );
  }
}
