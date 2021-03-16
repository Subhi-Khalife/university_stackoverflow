import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/error/exception.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/login/data/repositories/login_repositories_implementation.dart';
import 'package:university/features/login/domain/use_cases/login_use_email.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  UseCase loginUseEmail =
      LoginUseEmail(loginRepositories: LoginRepositoriesImplimentation());
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SendLoginRequest) {
      yield* _mapSendLoginRequest(event);
    }
  }

  Stream<LoginState> _mapSendLoginRequest(SendLoginRequest event) async* {
    yield LoadingState();
    final result = await loginUseEmail(
        LoginByEmailParam(email: event.email, password: event.password));

    yield result.fold((failure) {
      if (failure is MissingParamException)
        return LoginFailed();
      else {
        return LoginFailed();
      }
    }, (body) {
      return LoginSuccess();
    });
  }
}
