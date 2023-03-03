import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';

extension BlocExtension on BuildContext {
  ThemeBloc get themeBloc => read<ThemeBloc>();

  AuthenticationRepository get authenticationRepository =>
      read<AuthenticationRepository>();
}
