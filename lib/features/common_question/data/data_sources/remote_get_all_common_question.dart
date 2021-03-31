import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/unified_api/get_api.dart';
import 'package:university/core/unified_api/handling_exception.dart';
import 'package:university/features/common_question/data/models/common_question_model.dart';

class RemoteGetAllCommonQuestion with HandlingExceptionRequest {
  Future<Either<Failure, CommonQuestionModel>> getAllcommonQuestion() async {
    GetApi getApi = GetApi<CommonQuestionModel>(
      fromJson: commonQuestionModelFromJson,
      url: "commonquestions",
      requestName: " Get all commmon question ",
      token: "",
    );
    final request = getApi.callRequest;
    final response = await handlingExceptionRequest<CommonQuestionModel>(
        requestCall: request);
    return response.fold((failure) => Left(failure), (body) => Right(body));
  }
}
