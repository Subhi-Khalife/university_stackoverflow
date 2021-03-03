import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/unified_api/handling_exception.dart';
import 'package:university/core/unified_api/post_api.dart';
import 'package:university/features/login/data/models/login_model.dart';

class RemoteLoginByEmailDataSource with HandlingExceptionRequest {
  Future<Either<Failure, LoginModel>> loginByEmail(
      Map<String, dynamic> param) async {
    PostApi postApi = PostApi<LoginModel>(
      fromJson: loginModelFromJson,
      param: param,
      url: "",
      requestName: "Login By Email",
    );
    final request = postApi.callRequest;
    final response =
        await handlingExceptionRequest<LoginModel>(requestCall: request);
    return response.fold((failure) => Left(failure), (body) => Right(body));
  }
}
