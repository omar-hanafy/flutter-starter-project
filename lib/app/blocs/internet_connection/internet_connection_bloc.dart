import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionBloc
    extends Bloc<CheckConnection, InternetConnectionStatus> {
  InternetConnectionBloc() : super(InternetConnectionStatus.connected) {
    on<CheckConnection>(_checkConnection);
  }

  Future<void> _checkConnection(
      CheckConnection event, Emitter<InternetConnectionStatus> emit) async {
    if (kIsWeb) {
      emit(InternetConnectionStatus.connected);
    } else {
      await emit.onEach(
        InternetConnectionChecker().onStatusChange,
        onData: (InternetConnectionStatus status) => emit(status),
        onError: (error, stackTrace) {
          log(error.toString(), stackTrace: stackTrace);
          emit(InternetConnectionStatus.disconnected);
        },
      );
    }
  }
}

class CheckConnection {}
