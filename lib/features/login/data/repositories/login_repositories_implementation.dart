import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/login_repositories.dart';
import '../data_source/remote_login_by_email_data_source.dart';
import '../models/login_model.dart';

class LoginRepositoriesImplimentation implements LoginRepositories {
  @override
  Future<Either<Failure, LoginModel>> loginUseEmail(
      {Map<String, dynamic> items}) async {
    final result = await RemoteLoginByEmailDataSource().loginByEmail(items);
    return result.fold((failure) => Left(failure), (body) => Right(body));
  }
}
