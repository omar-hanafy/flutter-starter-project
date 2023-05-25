import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../app/app.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ChangeThemeMode>(_onChangeThemeMode);
  }

  void _onChangeThemeMode(ChangeThemeMode event, Emitter<ThemeState> emit) {
    final sysBr = event.context.sysBrightness;
    switch (event.changeType) {
      case BrightnessChangeType.dark:
        emit(ThemeState.getDark());
      case BrightnessChangeType.light:
        emit(ThemeState.getLight());
      case BrightnessChangeType.system:
        emit(ThemeState.getSystem(sysBr));
      case BrightnessChangeType.toggle:
        emit(ThemeState.getToggled(state._brightness));
    }
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) => ThemeState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ThemeState state) => state.toJson();
}
