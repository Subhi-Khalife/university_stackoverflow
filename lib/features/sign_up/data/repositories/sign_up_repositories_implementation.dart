import 'package:university/features/login/data/models/login_model.dart';
import 'package:university/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:university/features/sign_up/data/data_sources/sign_up_by_email_data_source.dart';
import 'package:university/features/sign_up/data/models/sign_up_model.dart';
import 'package:university/features/sign_up/domain/repositories/sign_up_repositories.dart';

class SignUpRepositoriesImplimentation implements SignUpRepositories {
  @override
  Future<Either<Failure, SignUpModel>> signUpByEmail(
      Map<String, dynamic> param) async {
    final callRequestResult =
        await SignUpByEmailDataSource().signUpByEmail(param);
    return callRequestResult.fold(
        (failure) => Left(failure), (body) => Right(body));
  }
}
