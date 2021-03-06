import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/get_api.dart';
import '../../../../core/unified_api/handling_exception.dart';
import '../models/common_question_model.dart';

class RemoteGetAllCommonQuestion with HandlingExceptionRequest {
  Future<Either<Failure, CommonQuestionModel>> getAllcommonQuestion(Map<String,dynamic>param) async {
    GetApi getApi = GetApi<CommonQuestionModel>(
      fromJson: commonQuestionModelFromJson,
      url: "commonquestions",
      requestName: " Get all commmon question ",
      token: "",
      param: param
    );
    final request = getApi.callRequest;
    final response = await handlingExceptionRequest<CommonQuestionModel>(
        requestCall: request);
    return response.fold((failure) => Left(failure), (body) => Right(body));
  }
}
