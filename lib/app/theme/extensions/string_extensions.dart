import 'package:flutter/material.dart';

extension ThemeStateStrignEx on String {
  Brightness get toBrightness {
    switch (this) {
      case 'dark':
        return Brightness.dark;
      default:
        return Brightness.light;
    }
  }

  ThemeMode get toThemeMode {
    switch (this) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}
