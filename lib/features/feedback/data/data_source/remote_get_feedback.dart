import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';
import '../../../../core/unified_api/post_api.dart';
import '../models/feedback_model.dart';

class RemoteGetFeedback with HandlingExceptionRequest {
  Future<Either<Failure, FeedbackModel>> postfeedback(
      Map<String, dynamic> param) async {
    final postApi = PostApi<FeedbackModel>(
      param: param,
      fromJson: feedbackModelFromJson,
      url: "feedback",
      requestName: "post feedback",
    );
    final callRequest = postApi.callRequest;
    Either<Failure, FeedbackModel> result = await postApi
        .handlingExceptionRequest<FeedbackModel>(requestCall: callRequest);
    return result;
  }
}
