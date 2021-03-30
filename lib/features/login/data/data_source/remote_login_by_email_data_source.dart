import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';
import '../../../../core/unified_api/post_api.dart';
import '../models/login_model.dart';

class RemoteLoginByEmailDataSource with HandlingExceptionRequest {
  Future<Either<Failure, LoginModel>> loginByEmail(
      Map<String, dynamic> param) async {
    PostApi postApi = PostApi<LoginModel>(
      fromJson: loginModelFromJson,
      param: param,
      url: "login",
      requestName: "Login By Email",
    );
    final request = postApi.callRequest;
    final response =
        await handlingExceptionRequest<LoginModel>(requestCall: request);
    return response.fold((failure) => Left(failure), (body) => Right(body));
  }
}
