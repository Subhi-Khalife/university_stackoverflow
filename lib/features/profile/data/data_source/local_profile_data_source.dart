import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';

class LocalProfileDataSource with HandlingExceptionRequest {


  Future<Either<Failure, User>> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final localResult = await prefs.getString("User");
    Either<Failure, User> endResult = json.decode(localResult);
    return endResult;
  }
}
