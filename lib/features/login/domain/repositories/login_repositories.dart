import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:university/features/login/data/models/login_model.dart';
import 'package:university/core/error/failures.dart';


abstract class LoginRepositories {
  Future<Either<Failure, LoginModel>> loginUseEmail({@required Map<String, dynamic> items});
}
