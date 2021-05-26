import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/feedback_model.dart';

abstract class FeedbackRepository {
  Future<Either<Failure, FeedbackModel>> getFeedback(
      {Map<String, dynamic> items});
}
