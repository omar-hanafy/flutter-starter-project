import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme_bloc.dart';

extension ThemeBlocExtension on BuildContext {
  ThemeBloc get themeBloc => read<ThemeBloc>();
}
