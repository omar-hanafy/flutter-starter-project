import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../app/app.dart';

class ThemeBloc extends HydratedBloc<ChangeBrightness, Brightness> {
  ThemeBloc({Brightness? brightness}) : super(brightness ?? Brightness.light) {
    on<ChangeBrightness>(_onChangeBrightness);
  }

  void _onChangeBrightness(ChangeBrightness event, Emitter<Brightness> emit) {
    final brightness = _getBrightness(event);
    if (state != brightness) {
      emit(brightness);
    }
  }

  Brightness _getBrightness(ChangeBrightness event) {
    switch (event.changeType) {
      case BrightnessTypesEvent.dark:
        return Brightness.dark;

      case BrightnessTypesEvent.light:
        return Brightness.light;

      case BrightnessTypesEvent.system:
        return event.context.sysBrightness;

      case BrightnessTypesEvent.toggle:
        return state == Brightness.light ? Brightness.dark : Brightness.light;
    }
  }

  @override
  Brightness? fromJson(Map<String, dynamic> json) =>
      json['state'] as int == 0 ? Brightness.dark : Brightness.light;

  @override
  Map<String, dynamic>? toJson(Brightness state) => {'state': state.index};
}

class ChangeBrightness {
  ChangeBrightness(this.context,
      {this.changeType = BrightnessTypesEvent.toggle});

  final BuildContext context;
  final BrightnessTypesEvent changeType;
}
