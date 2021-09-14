import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/common_question_model.dart';

abstract class CommonQuestionRepositories {
  Future<Either<Failure, CommonQuestionModel>> getAllCommonQuestion(Map<String,dynamic>param);
  Future<Either<Failure, CommonQuestionModel>> getCommonQuestionForCollage(String collageId,Map<String,dynamic>param);

}
