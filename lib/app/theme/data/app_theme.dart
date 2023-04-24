// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app.dart';

/// Namespace for the App [ThemeData].
abstract class AppTheme {
  static final _materialStatePropertyPrimaryColor =
      MaterialStateProperty.all(AppColors.primaryColor);

  static ThemeData get defaultTheme => ThemeData(
        // fontFamily: '',
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
        switchTheme: SwitchThemeData(
          thumbColor: _materialStatePropertyPrimaryColor,
        ),
        radioTheme: RadioThemeData(
          fillColor: _materialStatePropertyPrimaryColor,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: _materialStatePropertyPrimaryColor,
        ),
        colorScheme: _defaultColorScheme,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        splashColor: AppColors.primaryColor,
        cardTheme: const CardTheme(surfaceTintColor: Colors.transparent),
        appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
        navigationBarTheme: const NavigationBarThemeData(),
        navigationDrawerTheme: const NavigationDrawerThemeData(),
        navigationRailTheme: const NavigationRailThemeData(
          selectedLabelTextStyle: TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelTextStyle:
              TextStyle(color: AppColors.darkGrey, fontSize: 10),
          unselectedIconTheme: IconThemeData(color: AppColors.darkGrey),
          selectedIconTheme: IconThemeData(color: AppColors.black),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        // fontFamily: '',
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
        switchTheme: SwitchThemeData(
          thumbColor: _materialStatePropertyPrimaryColor,
        ),
        radioTheme: RadioThemeData(
          fillColor: _materialStatePropertyPrimaryColor,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: _materialStatePropertyPrimaryColor,
        ),
        colorScheme: _darkColorScheme,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundDark,
        splashColor: AppColors.primaryColor,
        cardTheme: const CardTheme(surfaceTintColor: Colors.transparent),
        appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
        navigationBarTheme: const NavigationBarThemeData(),
        navigationDrawerTheme: const NavigationDrawerThemeData(),
        navigationRailTheme: const NavigationRailThemeData(
          selectedLabelTextStyle: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelTextStyle:
              TextStyle(color: AppColors.grey, fontSize: 10),
          unselectedIconTheme: IconThemeData(color: AppColors.grey),
          selectedIconTheme: IconThemeData(color: AppColors.white),
        ),
      );

  static ColorScheme get _defaultColorScheme => const ColorScheme.light(
        surface: AppColors.surface,
        onSurface: AppColors.black,
        primary: AppColors.primaryColor,
        onPrimary: AppColors.onPrimaryColor,
        secondary: AppColors.primaryColor,
        onSecondary: AppColors.onPrimaryColor,
        error: AppColors.error,
        onError: AppColors.onError,
        background: AppColors.background,
      );

  static ColorScheme get _darkColorScheme => const ColorScheme.dark(
        surface: AppColors.surfaceDark,
        onSurface: Colors.white,
        primary: AppColors.primaryColor,
        onPrimary: AppColors.onPrimaryColorDark,
        secondary: AppColors.primaryColor,
        onSecondary: AppColors.onPrimaryColorDark,
        error: AppColors.error,
        onError: AppColors.onError,
        background: AppColors.background,
      );

  static MaterialStateProperty<Color?> get _getMaterialStatePropertyColor =>
      MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primaryColor;
          }
          return null;
        },
      );

  static CupertinoThemeData get defaultCupertinoTheme => CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primaryColor,
        primaryContrastingColor: AppColors.onPrimaryColor,
        textTheme: _defaultCupertinoTextThemeData,
        barBackgroundColor: AppColors.navBarBackground,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
      );

  static CupertinoThemeData get darkCupertinoTheme => CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryColor,
        primaryContrastingColor: AppColors.onPrimaryColor,
        textTheme: _darkCupertinoTextThemeData,
        barBackgroundColor: AppColors.navBarBackground,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
      );

  static CupertinoTextThemeData get _defaultCupertinoTextThemeData =>
      const CupertinoTextThemeData();

  static CupertinoTextThemeData get _darkCupertinoTextThemeData =>
      const CupertinoTextThemeData();
}
