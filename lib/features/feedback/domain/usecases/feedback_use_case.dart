import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/feedback_model.dart';
import '../repositories/feedback_repository.dart';

class FeedbackUseCase extends UseCase<FeedbackModel, GetFeedbackParam> {
  final FeedbackRepository feedbackRepository;

  FeedbackUseCase({this.feedbackRepository});

  @override
  Future<Either<Failure, FeedbackModel>> call(
      GetFeedbackParam getAdsParam) async {
    final result = await feedbackRepository.getFeedback(
      items: getAdsParam.getParam(),
    );
    return result;
  }
}

class GetFeedbackParam {
  final String feedbackEmail;
  final String feedbackMessage;
  final String feedbackName;

  GetFeedbackParam(
      {this.feedbackEmail, this.feedbackMessage, this.feedbackName});

  getParam() => {
        "feedback_email": feedbackEmail,
        "feedback_message": feedbackMessage,
        "feedback_name": feedbackName,
      };
}
