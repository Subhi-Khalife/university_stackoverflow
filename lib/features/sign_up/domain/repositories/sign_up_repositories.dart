import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/sign_up_model.dart';

abstract class SignUpRepositories {
  Future<Either<Failure, SignUpModel>> signUpByEmail(
      {Map<String, dynamic> param});
}
