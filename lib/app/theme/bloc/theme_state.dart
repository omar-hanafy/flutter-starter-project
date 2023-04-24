part of 'theme_bloc.dart';

class ThemeState {
  const ThemeState({
    Brightness brightness = Brightness.light,
    ThemeMode themeMode = ThemeMode.system,
  })  : _themeMode = themeMode,
        _brightness = brightness;

  factory ThemeState.getDark() {
    return const ThemeState(
      brightness: Brightness.dark,
      themeMode: ThemeMode.dark,
    );
  }

  factory ThemeState.getLight() {
    return const ThemeState(
      themeMode: ThemeMode.light,
    );
  }

  factory ThemeState.getSystem(Brightness sysBrightness) {
    return ThemeState(
      brightness: sysBrightness,
    );
  }

  factory ThemeState.getToggled(Brightness currentBr) {
    return ThemeState(
      brightness: currentBr.isDark ? Brightness.light : Brightness.dark,
      themeMode: currentBr.isDark ? ThemeMode.light : ThemeMode.dark,
    );
  }

  factory ThemeState.fromJson(Map<String, dynamic> json) {
    return ThemeState(
      brightness: '${json['brightness']}'.toBrightness,
      themeMode: '${json['themeMode']}'.toThemeMode,
    );
  }

  final Brightness _brightness;

  final ThemeMode _themeMode;

  Brightness get brightness => _brightness;

  ThemeMode get themeMode => _themeMode;

  // ThemeData get adaptiveMaterialTheme => _brightness == Brightness.light
  //     ? AppTheme.defaultTheme
  //     : AppTheme.darkTheme;
  //

  CupertinoThemeData get adaptiveCupertinoTheme =>
      _brightness == Brightness.light
          ? AppTheme.defaultCupertinoTheme
          : AppTheme.darkCupertinoTheme;

  Map<String, dynamic> toJson() => {
        'brightness': _brightness.name,
        'themeMode': _themeMode.name,
      };

  @override
  String toString() {
    return 'ThemeState{_brightness: $_brightness, _themeMode: $_themeMode}';
  }
}
