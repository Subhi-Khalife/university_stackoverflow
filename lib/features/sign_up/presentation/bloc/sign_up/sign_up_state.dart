part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SuccessSignUp  extends SignUpState {}

class FailedSignUp extends SignUpState {}

