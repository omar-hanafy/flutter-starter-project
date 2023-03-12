import 'package:flutter/material.dart';

import '../../app.dart';

/// Defines the color palette for the App UI.
abstract class AppColors {
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color black26 = Colors.black26;
  static const Color charcoal = Color(0xFF36454F);
  static const Color whiteBackground = Color(0xFFE8EAED);
  static const Color scaffoldBackground = Color(0xFFF5F7FA);
  static const Color scaffoldBackgroundDark = Color(0xFF303030);
  static const Color navBarBackground = Colors.white;
  static const Color navBarBackgroundDark = Colors.grey;
  static const Color transparent = Colors.transparent;
  static const Color primaryColor = Color(0xfff2b43f);
  static const Color onPrimaryColor = Colors.black;
  static const Color onPrimaryColorDark = Colors.white;
  static const Color background = Colors.grey;
  static const Color onBackground = Colors.white;
  static const Color error = Colors.red;
  static const Color onError = Colors.black;
  static const Color grey = Color(0xFFEBEBEB);
  static const Color darkGrey = Color(0xff424242);
  static const Color secondary = Color(0xFFFB5246);
  static const Color green = Color(0xFF3fBC5C);
}

class ResponsiveAppColor {
  const ResponsiveAppColor(this.br);

  final Brightness br;

  Color get black => br.isDark ? Colors.white : Colors.black;

  Color get white => br.isDark ? Colors.black : Colors.white;

  Color get grey => br.isDark ? Colors.white12 : Colors.black12;

  Color get lightGrey =>
      br.isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1);

  Color get darkGrey => br.isDark ? Colors.white54 : Colors.black54;

  Color get blackShadow => br.isDark
      ? AppColors.black.withOpacity(0.05)
      : AppColors.grey.withOpacity(0.2);

  Color get primaryColorShadow => br.isDark
      ? AppColors.primaryColor.withOpacity(0.05)
      : AppColors.primaryColor.withOpacity(0.1);

  Color get scaffoldBackground => br.isDark
      ? AppColors.scaffoldBackground
      : AppColors.scaffoldBackgroundDark;
}
