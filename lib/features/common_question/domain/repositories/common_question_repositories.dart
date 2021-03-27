import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/common_question/data/models/common_question_model.dart';

abstract class CommonQuestionRepositories {
  Future<Either<Failure, CommonQuestionModel>> getAllCommonQuestion();
  Future<Either<Failure, CommonQuestionModel>> getCommonQuestionForCollage(String collageId);

}
