import 'package:university/core/unified_api/post_api.dart';
import 'package:university/features/login/data/data_source/remote_login_by_email_data_source.dart';
import 'package:university/features/login/data/models/login_model.dart';
import 'package:dartz/dartz.dart';
import 'package:university/features/login/domain/repositories/login_repositories.dart';
import 'package:university/core/error/failures.dart';

class LoginRepositoriesImplimination implements LoginRepositories {
  @override
  Future<Either<Failure, LoginModel>> loginUseEmail({Map<String, dynamic> items}) async {
    final result=await RemoteLoginByEmailDataSource().loginByEmail(items);
    return result.fold((failure) => Left(failure), (body) => Right(body));
  }
}
