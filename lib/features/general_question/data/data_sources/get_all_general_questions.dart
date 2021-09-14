import 'package:dartz/dartz.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/unified_api/get_api.dart';
import 'package:university/features/general_question/data/models/general_questions_model.dart';
import 'package:university/features/post/data/models/posts_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';

class GetAllGeneralQuetion with HandlingExceptionRequest {
  Future<Either<Failure, GeneralQuestionsModel>> getAllGeneralQuetion(Map<String, dynamic> items) async {
    ConstantInfo constantInfo = ConstantInfo.getInstance();

    final postApi = GetApi<GeneralQuestionsModel>(
        token: constantInfo.userInfo.token,
        fromJson: generalQuestionsModelFromJson,
        url: "post/general/get",
        requestName: "Get General Posts",
        param: items);
    final callRequest = postApi.callRequest;
    Either<Failure, GeneralQuestionsModel> result =
        await handlingExceptionRequest<GeneralQuestionsModel>(requestCall: callRequest);
    return result;
  }
}
