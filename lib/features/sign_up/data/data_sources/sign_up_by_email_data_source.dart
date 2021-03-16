import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/unified_api/handling_exception.dart';
import 'package:university/core/unified_api/post_api.dart';
import 'package:university/features/login/data/models/login_model.dart';
import 'package:university/features/sign_up/data/models/sign_up_model.dart';

class SignUpByEmailDataSource with HandlingExceptionRequest {
  Future<Either<Failure, SignUpModel>> signUpByEmail(
      Map<String, dynamic> param) async {
    final postApi = PostApi<SignUpModel>(
      fromJson: signUpModelFromJson,
      param: param,
      url: "register",
      requestName: "Sign up by Emai",
    );
    final callRequest = postApi.callRequest;
    final result =
        await postApi.handlingExceptionRequest(requestCall: callRequest);
    return result.fold((failure) => Left(failure), (body) => Right(body));
  }
}
