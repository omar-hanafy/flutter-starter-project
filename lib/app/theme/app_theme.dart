import 'package:flutter/material.dart';

import '../app.dart';

/// Namespace for the App [ThemeData].
class AppTheme {
  AppTheme(this.languageCode);

  final String languageCode;

  static ColorScheme _defaultColorScheme(Brightness br) => ColorScheme(
        brightness: br,
        surface: AppColor.primaryColor,
        onSurface: AppColor.onPrimaryColor,
        error: AppColor.error,
        onError: AppColor.onError,
        background: AppColor.background,
        onBackground: AppColor.onBackground,
        primary: AppColor.primaryColor,
        onPrimary: AppColor.onPrimaryColor,
        secondary: AppColor.primaryColor,
        onSecondary: AppColor.onPrimaryColor,
      );

  ThemeData get _defaultThemeData => ThemeData(
      fontFamily: languageCode == 'ar' ? 'Cairo' : 'SF-Pro-Rounded',
      toggleableActiveColor: AppColor.primaryColor,
      primaryColor: AppColor.primaryColor);

  Color getAdaptiveScaffoldBackgroundColor(Brightness br) =>
      br == Brightness.light
          ? AppColor.scaffoldBackground
          : AppColor.scaffoldBackgroundDark;

  ThemeData getAdaptiveTheme(Brightness br) => _defaultThemeData.copyWith(
      colorScheme: _defaultColorScheme(br),
      scaffoldBackgroundColor: getAdaptiveScaffoldBackgroundColor(br));
}

//   static TextTheme get _normalTextTheme {
//     return TextTheme(
//       headline1: _defaultThemeData.textTheme.headline1,
//       headline2: _defaultThemeData.textTheme.headline2,
//       headline3: _defaultThemeData.textTheme.headline3,
//       headline4: _defaultThemeData.textTheme.headline4,
//       headline5: _defaultThemeData.textTheme.headline5,
//       headline6: _defaultThemeData.textTheme.headline6,
//       subtitle1: _defaultThemeData.textTheme.subtitle1,
//       subtitle2: _defaultThemeData.textTheme.subtitle2,
//       bodyText1: _defaultThemeData.textTheme.bodyText1,
//       bodyText2: _defaultThemeData.textTheme.bodyText2,
//       caption: _defaultThemeData.textTheme.caption,
//       overline: _defaultThemeData.textTheme.overline,
//       button: _defaultThemeData.textTheme.button,
//     );
//   }
//
//  static TextTheme get _smallTextTheme {
//     return TextTheme(
//       headline1: _defaultThemeData.textTheme.headline1?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.headline1!.fontSize! * _smallTextScaleFactor,
//       ),
//       headline2: _defaultThemeData.textTheme.headline2?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.headline2!.fontSize! * _smallTextScaleFactor,
//       ),
//       headline3: _defaultThemeData.textTheme.headline3?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.headline3!.fontSize! * _smallTextScaleFactor,
//       ),
//       headline4: _defaultThemeData.textTheme.headline4?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.headline4!.fontSize! * _smallTextScaleFactor,
//       ),
//       headline5: _defaultThemeData.textTheme.headline5?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.headline5!.fontSize! * _smallTextScaleFactor,
//       ),
//       headline6: _defaultThemeData.textTheme.headline6?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.headline6!.fontSize! * _smallTextScaleFactor,
//       ),
//       subtitle1: _defaultThemeData.textTheme.subtitle1?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.subtitle1!.fontSize! * _smallTextScaleFactor,
//       ),
//       subtitle2: _defaultThemeData.textTheme.subtitle2?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.subtitle2!.fontSize! * _smallTextScaleFactor,
//       ),
//       bodyText1: _defaultThemeData.textTheme.bodyText1?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.bodyText1!.fontSize! * _smallTextScaleFactor,
//       ),
//       bodyText2: _defaultThemeData.textTheme.bodyText2?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.bodyText2!.fontSize! * _smallTextScaleFactor,
//       ),
//       caption: _defaultThemeData.textTheme.caption?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.caption!.fontSize! * _smallTextScaleFactor,
//       ),
//       overline: _defaultThemeData.textTheme.overline?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.overline!.fontSize! * _smallTextScaleFactor,
//       ),
//       button: _defaultThemeData.textTheme.button?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.button!.fontSize! * _smallTextScaleFactor,
//       ),
//     );
//   }
//
//   static  TextTheme get _largeTextTheme {
//     return TextTheme(
//       headline1: _defaultThemeData.textTheme.headline1?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.headline1!.fontSize! * _largeTextScaleFactor,
//       ),
//       headline2: _defaultThemeData.textTheme.headline2?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.headline2!.fontSize! * _largeTextScaleFactor,
//       ),
//       headline3: _defaultThemeData.textTheme.headline3?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.headline3!.fontSize! * _largeTextScaleFactor,
//       ),
//       headline4: _defaultThemeData.textTheme.headline4?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.headline4!.fontSize! * _largeTextScaleFactor,
//       ),
//       headline5: _defaultThemeData.textTheme.headline5?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.headline5!.fontSize! * _largeTextScaleFactor,
//       ),
//       headline6: _defaultThemeData.textTheme.headline6?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.headline6!.fontSize! * _largeTextScaleFactor,
//       ),
//       subtitle1: _defaultThemeData.textTheme.subtitle1?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.subtitle1!.fontSize! * _largeTextScaleFactor,
//       ),
//       subtitle2: _defaultThemeData.textTheme.subtitle2?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.subtitle2!.fontSize! * _largeTextScaleFactor,
//       ),
//       bodyText1: _defaultThemeData.textTheme.bodyText1?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.bodyText1!.fontSize! * _largeTextScaleFactor,
//       ),
//       bodyText2: _defaultThemeData.textTheme.bodyText2?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.bodyText2!.fontSize! * _largeTextScaleFactor,
//       ),
//       caption: _defaultThemeData.textTheme.caption?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.caption!.fontSize! * _largeTextScaleFactor,
//       ),
//       overline: _defaultThemeData.textTheme.overline?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.overline!.fontSize! * _largeTextScaleFactor,
//       ),
//       button: _defaultThemeData.textTheme.button?.copyWith(
//         // color: brightness == Brightness.light ? Colors.black : Colors.white,
//         fontSize: _normalTextTheme.button!.fontSize! * _largeTextScaleFactor,
//       ),
//     );
//   }
// }
