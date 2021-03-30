import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/entities/user.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';
import '../../../../core/unified_api/post_api.dart';
import '../models/sign_up_model.dart';

class SignUpByEmailDataSource with HandlingExceptionRequest {
  SharedPreferences prefs;

  Future<Either<Failure, SignUpModel>> signUpByEmail(Map<String, dynamic> param) async {
    final postApi = PostApi<SignUpModel>(
      fromJson: signUpModelFromJson,
      param: param,
      url: "register",
      requestName: "Sign up by Emai"
    );
    final callRequest = postApi.callRequest;
    final result =
    await handlingExceptionRequest<SignUpModel>(requestCall: callRequest);
    return result.fold((failure) => Left(failure), (body) => Right(body));
  }
}