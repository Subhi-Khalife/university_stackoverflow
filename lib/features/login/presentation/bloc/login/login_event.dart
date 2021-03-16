part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}


class SendLoginRequest extends LoginEvent {
  final String email;
  final String password;
  SendLoginRequest({this.email, this.password});
  @override
  List<Object> get props => [email,password];
}

class FailedLoginRequest extends LoginEvent {}
