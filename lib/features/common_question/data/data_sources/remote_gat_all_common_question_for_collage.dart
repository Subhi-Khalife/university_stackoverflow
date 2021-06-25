import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/get_api.dart';
import '../../../../core/unified_api/handling_exception.dart';
import '../models/common_question_model.dart';

class RemoteGetAllCommonQuestionForCollage with HandlingExceptionRequest {
  Future<Either<Failure, CommonQuestionModel>> getAllCommonQuestionForCollage(
      {String collageId,@required Map<String,dynamic>param}) async {
    GetApi getApi = GetApi(
        requestName: "commen question for collage id",
        fromJson: commonQuestionModelFromJson,
        token: "",
        url: "commonquestions/$collageId",
        param: param
        );
    final request = getApi.callRequest;
    final response = await handlingExceptionRequest<CommonQuestionModel>(
        requestCall: request);
    return response.fold((failure) => Left(failure), (body) => Right(body));
  }
}
