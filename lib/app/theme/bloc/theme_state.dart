part of 'theme_bloc.dart';

class ThemeState {
  ThemeState({
    Brightness? brightness,
    ThemeMode? themeMode,
  })  : _themeMode = themeMode,
        _brightness = brightness;

  ThemeState.getDark() {
    _brightness = Brightness.dark;
    _themeMode = ThemeMode.dark;
  }

  ThemeState.getLight() {
    _brightness = Brightness.dark;
    _themeMode = ThemeMode.dark;
  }

  ThemeState.getSystem(Brightness sysBrightness) {
    _brightness = sysBrightness;
    _themeMode = ThemeMode.system;
  }

  ThemeState.getToggled() {
    if (_brightness == Brightness.dark) {
      _brightness = Brightness.light;
      _themeMode = ThemeMode.light;
    }
    if (_brightness == Brightness.dark) {
      _brightness = Brightness.light;
      _themeMode = ThemeMode.light;
    }
  }

  ThemeState.fromJson(Map<String, dynamic> json) {
    _brightness = '${json['brightness']}'.toBrightness;
    _themeMode = '${json['themeMode']}'.toThemeMode;
  }

  Brightness? _brightness;
  ThemeMode? _themeMode = ThemeMode.system;

  Brightness get brightness => _brightness!;

  ThemeMode get themeMode => _themeMode!;

  ThemeData get adaptiveMaterialTheme => _brightness == Brightness.light
      ? AppTheme.defaultTheme
      : AppTheme.darkTheme;

  CupertinoThemeData get adaptiveCupertinoTheme =>
      _brightness == Brightness.light
          ? AppTheme.defaultCupertinoTheme
          : AppTheme.darkCupertinoTheme;

  Map<String, dynamic> toJson() => {
        'brightness': brightness.name,
        'themeMode': themeMode.name,
      };
}
