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
    print("the token ins ${body.user.token}");

      return LoginSuccess(user: body.user);
    });
  }
}
/*

eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI4IiwianRpIjoiZDkyOGJhM2JmNWI0ZDI0MTZhNDA1MzQ2MWJlNzhjMTY2Nzc3NDgyNjAwMGZmYzA1ZGUxYzgxY2Q3MjgyMDcwY2U0ODU3ZmMyMTcyYzJkNDAiLCJpYXQiOjE2MjQ2MzM1OTcuMjkzNDQxMDU3MjA1MjAwMTk1MzEyNSwibmJmIjoxNjI0NjMzNTk3LjI5MzQ0NTExMDMyMTA0NDkyMTg3NSwiZXhwIjoxNjU2MTY5NTk3LjI4ODIzMDg5NTk5NjA5Mzc1LCJzdWIiOiIxMCIsInNjb3BlcyI6W119.OLJx6Yrc-xs0786ojvnFQ40ENJBPGt8U5sOJmaMtmLETpyvRJfLXj_Geip4hISum1cJw1JZxo7h5Jg_22On3EvLSJkgKGxZBQ14iZQYFqW_c8FhWaEKcviVdfcA7HFMrl3V5FJT-Z3wW6i7zMh6X8vjQbLW7gNRHdh0f4EDnVict0P6ENPgZTsxla3_dTSrwpyVC0tCtnu8iY6zgZQe-5QJnh8v2mbaZi02NYNXNXXlTcPHRum_jQ6PTORNbTIQMONapQikY8tvos7Hh1scelh-IB7HJvSCbZMTulOoV9Y_CGEwAx2jqUzxFCqKpZ965a0oNGXfRswLk6uTH7kbVWDB72pUgZbwOPgGvAAyzguAJG_5v6tbPNE55ssHTpB1FK1dZGGUeK5F-JEJSO7h6WtqRm-S6RkndMW01DpfO3QBA0PGLIWtkn5gNjhYRPZlK-a74jBE60DWrT0WiHiMzSOn23pwMosmdnh80l6axtU9D_mJvuMq5pBhST7K0BiQzuXZ3Zx3I2E_nAAz14fPioUJUz4NCodTG_dHQgJlZZCOaIvC6N5RrlmFb2zkjb-Hoq5jGEJYxmUfUlz3Cs20Ru6Da63ZQ3a4ziXZ1xTaF_JBR8BRIvpg4s5D4Ayh8_ube1WndFzQnUJXvjM7
*/