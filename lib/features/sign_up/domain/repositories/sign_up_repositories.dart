import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/sign_up/data/models/sign_up_model.dart';

abstract class SignUpRepositories {
  Future<Either<Failure, SignUpModel>> signUpByEmail(
      Map<String, dynamic> param);
}
