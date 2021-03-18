import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/sign_up_repositories.dart';
import '../data_sources/sign_up_by_email_data_source.dart';
import '../models/sign_up_model.dart';

class SignUpRepositoriesImplimentation implements SignUpRepositories {
  @override
  Future<Either<Failure, SignUpModel>> signUpByEmail(
      {Map<String, dynamic> param}) async {
    final callRequestResult =
        await SignUpByEmailDataSource().signUpByEmail(param);
    return callRequestResult.fold(
        (failure) => Left(failure), (body) => Right(body));
  }
}
