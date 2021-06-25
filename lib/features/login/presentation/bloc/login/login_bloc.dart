import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/entities/user.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/widget/show_message.dart';
import 'package:university/features/login/data/models/login_model.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../data/repositories/login_repositories_implementation.dart';
import '../../../domain/use_cases/login_use_email.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  UseCase loginUseEmail =
      LoginUseEmail(loginRepositories: LoginRepositoriesImplimentation());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SendLoginRequest) {
      {
        print("inside theis");
        yield* _mapSendLoginRequest(event);
      }
    }
  }

  Stream<LoginState> _mapSendLoginRequest(SendLoginRequest event) async* {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    yield LoadingState();
    Either<Failure, LoginModel> result = await loginUseEmail(
        LoginByEmailParam(email: event.email, password: event.password));

    yield result.fold((failure) {
      showMessage("Error Happened try again");
      if (failure is MissingParamException)
        return LoginFailed();
      else {
        return LoginFailed();
      }
    }, (body) {
      sharedPreferences.setBool("loginSuccess", true);
      sharedPreferences.setString("user", loginModelToJson(body));
      return LoginSuccess(user: body.user);
    });
  }
}
