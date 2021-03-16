import 'package:dartz/dartz.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/login/data/models/login_model.dart';
import 'package:university/features/login/domain/repositories/login_repositories.dart';
import 'package:university/core/error/failures.dart';

class LoginUseEmail implements UseCase<LoginModel, LoginByEmailParam> {
  final LoginRepositories loginRepositories;
  LoginUseEmail({this.loginRepositories});
  @override
  Future<Either<Failure, LoginModel>> call(LoginByEmailParam params) async {
    final paramLoginJson = params.getParam();
    final value = await loginRepositories.loginUseEmail(items: paramLoginJson);
    return value.fold((failure) => Left(failure), (body) => Right(body));
  }
}

class LoginByEmailParam {
  String email;

  String password;

  LoginByEmailParam({this.email, this.password});

  getParam() => {"email": email, "password": password};
}
