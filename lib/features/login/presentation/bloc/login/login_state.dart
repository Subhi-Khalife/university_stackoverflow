part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({this.user});
}

class LoginFailed extends LoginState{}

class LoadingState extends LoginState{}