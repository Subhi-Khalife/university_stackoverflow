part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SuccessSignUp extends SignUpState {
  final User user;

  SuccessSignUp({this.user});
}

class FailedSignUp extends SignUpState {}

class LoadingState extends SignUpState {}

class ChangeToSecondScreenState extends SignUpState {
  final bool state;
  ChangeToSecondScreenState({this.state});
}