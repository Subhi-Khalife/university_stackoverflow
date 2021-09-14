part of 'login_bloc.dart';

abstract class LoginEvent  {
  const LoginEvent();

}


class SendLoginRequest extends LoginEvent {
  final String email;
  final String password;
  SendLoginRequest({this.email, this.password});
}

class FailedLoginRequest extends LoginEvent {}
