import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/widget/show_message.dart';
import 'package:university/features/login/data/models/login_model.dart';

import '../../../../../core/entities/user.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../data/repositories/sign_up_repositories_implementation.dart';
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
      yield* _mapSendSignUpRequestEvent(event);
    } else if (event is ChangeToSecondScreen) {
      yield ChangeToSecondScreenState(state: false);
    }
  }

  Stream<SignUpState> _mapSendSignUpRequestEvent(
      SendSignUpRequestEvent event) async* {
    yield LoadingState();
    Either<Failure, LoginModel> result = await signUpUsingEmail(SignUpParam(
      collageNumber: event.collageNumber,
      collegeId: event.collegeId,
      email: event.email,
      firstName: event.firstName,
      lastName: event.lastName,
      mobile: event.mobile,
      password: event.password,
      universityId: event.universityId,
    ));
    yield result.fold(
      (failure) =>
          failure is MissingParamException ? FailedSignUp() : FailedSignUp(),
      (success) {
        showMessage("success signup wait admin to verify your request");
        return SuccessSignUp(user: success.user);
      },
    );
  }
}
