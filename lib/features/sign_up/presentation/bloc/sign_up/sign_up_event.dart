part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SendSignUpRequestEvent extends SignUpEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String mobile;
  final int collegeId;
  final int universityId;
  final String collageNumber;

  SendSignUpRequestEvent(
      {this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.mobile,
      this.collegeId,
      this.universityId,
      this.collageNumber});
  @override
  List<Object> get props => [
        email,
        password,
        firstName,
        lastName,
        mobile,
        collegeId,
        universityId,
        collageNumber,
      ];
}

class FailedSignUpRequest extends SignUpEvent {}

class ChangeToSecondScreen extends SignUpEvent{}