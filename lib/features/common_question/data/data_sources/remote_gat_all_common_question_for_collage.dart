import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/unified_api/get_api.dart';
import 'package:university/core/unified_api/handling_exception.dart';
import 'package:university/features/common_question/data/models/common_question_model.dart';

class RemoteGetAllCommonQuestionForCollage with HandlingExceptionRequest {
  Future<Either<Failure, CommonQuestionModel>> getAllCommonQuestionForCollage(
      {String collageId}) async {
    GetApi getApi = GetApi(
        requestName: "commen question for collage id",
        fromJson: commonQuestionModelFromJson,
        token: "",
        url: "commonquestions/$collageId");
    final request = getApi.callRequest;
    final response = await handlingExceptionRequest<CommonQuestionModel>(
        requestCall: request);
    return response.fold((failure) => Left(failure), (body) => Right(body));
  }
}
