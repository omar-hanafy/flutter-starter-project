import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ReposBlocExtension on BuildContext {
  AuthenticationRepository get authenticationRepository =>
      read<AuthenticationRepository>();
}
