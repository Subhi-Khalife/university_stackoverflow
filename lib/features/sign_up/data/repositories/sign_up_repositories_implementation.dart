
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/features/login/data/models/login_model.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/sign_up_repositories.dart';
import '../data_sources/sign_up_by_email_data_source.dart';
import '../models/sign_up_model.dart';

class SignUpRepositoriesImplimentation implements SignUpRepositories {
  SharedPreferences prefs;

  @override
  Future<Either<Failure, LoginModel>> signUpByEmail({Map<String, dynamic> param}) async {
    Either<Failure, LoginModel> callRequestResult =
    await SignUpByEmailDataSource().signUpByEmail(param);
    return callRequestResult;
  }
}
