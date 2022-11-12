part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState._({
    required this.status,
    //todo: add this line this.user = FirebaseUserModel.empty,
    this.user = FirebaseUserModel.empty,
  });

  const AppState.authenticated(FirebaseUserModel user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final FirebaseUserModel user;

  @override
  List<Object> get props => [status, user];
}
