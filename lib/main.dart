import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lib.dart';

void main() => bootstrap(() => const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        debugPrint('$state');
        return context.isIOS
            ? CupertinoApp.router(
                theme: state.adaptiveCupertinoTheme,
                onGenerateTitle: (BuildContext context) =>
                    context.l10n?.appTitle ?? 'Project Title',
                routerConfig: RouterManager.router,
                locale: const Locale('en', 'EG'),
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
              )
            : MaterialApp.router(
                themeMode: state.themeMode,
                theme: AppTheme.defaultTheme,
                darkTheme: AppTheme.darkTheme,
                onGenerateTitle: (BuildContext context) =>
                    context.l10n?.appTitle ?? 'Project Title',
                routerConfig: RouterManager.router,
                locale: const Locale('en', 'EG'),
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
              );
      },
    );
  }
}
