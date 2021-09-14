
import 'package:dartz/dartz.dart';
import 'package:university/features/login/data/models/login_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';
import '../../../../core/unified_api/post_api.dart';
import '../models/sign_up_model.dart';

class SignUpByEmailDataSource with HandlingExceptionRequest {
  Future<Either<Failure, LoginModel>> signUpByEmail(
      Map<String, dynamic> param) async {
    final postApi = PostApi<LoginModel>(
        fromJson: loginModelFromJson,
        param: param,
        url: "register",
        requestName: "Sign up by Emai");
    final callRequest = postApi.callRequest;
    Either<Failure, LoginModel> result =
    await handlingExceptionRequest<LoginModel>(requestCall: callRequest);
    return result;
  }
}
