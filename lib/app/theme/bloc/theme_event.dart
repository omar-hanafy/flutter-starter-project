part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ChangeThemeMode extends ThemeEvent {
  ChangeThemeMode(
    this.context, {
    this.changeType = BrightnessChangeType.toggle,
  });

  final BuildContext context;
  final BrightnessChangeType changeType;
}
