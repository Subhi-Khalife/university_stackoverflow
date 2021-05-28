import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/feedback_repository.dart';
import '../data_source/remote_get_feedback.dart';
import '../models/feedback_model.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  @override
  Future<Either<Failure, FeedbackModel>> getFeedback(
      {Map<String, dynamic> items}) async {
    final postFeedback = await RemoteGetFeedback().postfeedback(items);
    return postFeedback;
  }
}
