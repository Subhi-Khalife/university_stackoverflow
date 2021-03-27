import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:university/features/sign_up/data/repositories/sign_up_repositories_implementation.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../domain/use_cases/sign_up_email.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());
  UseCase signUpUsingEmail = SignUpByEmail(
    signUpRepositories: SignUpRepositoriesImplimentation(),
  );

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SendSignUpRequestEvent) {
      yield LoadingState();
      final result = await signUpUsingEmail(SignUpParam(
        collageNumber: event.collageNumber,
        collegeId: event.collegeId,
        email: event.email,
        firstName: event.firstName,
        lastName: event.lastName,
        mobile: event.mobile,
        password: event.password,
        universityId: event.universityId,
      ));
      print("the result is ");
      yield result.fold(
        (failure) =>
            failure is MissingParamException ? FailedSignUp() : FailedSignUp(),
        (success){
          print("the state is ${success}");
          return SuccessSignUp();
        },
      );
    }
  }
}
