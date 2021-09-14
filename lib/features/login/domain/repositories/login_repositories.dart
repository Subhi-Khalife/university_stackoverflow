import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/login_model.dart';

abstract class LoginRepositories {
  Future<Either<Failure, LoginModel>> loginUseEmail(
      {@required Map<String, dynamic> items});
}
