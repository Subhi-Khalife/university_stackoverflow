import 'package:dartz/dartz.dart';
import 'package:university/features/login/data/models/login_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/sign_up_model.dart';

abstract class SignUpRepositories {
  Future<Either<Failure, LoginModel>> signUpByEmail(
      {Map<String, dynamic> param});
}
