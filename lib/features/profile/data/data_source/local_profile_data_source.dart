import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/entities/user.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/unified_api/handling_exception.dart';

class LocalProfileDataSource with HandlingExceptionRequest {
  SharedPreferences prefs;

  Future<Either<Failure, User>> getUserProfile() async {
    final localResult = await prefs.getString("User");
    Either<Failure, User> endResult = json.decode(localResult);
    return endResult;
  }
}
