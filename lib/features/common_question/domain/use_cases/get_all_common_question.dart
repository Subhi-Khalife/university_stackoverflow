import 'package:university/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/common_question/data/models/common_question_model.dart';
import 'package:university/features/common_question/domain/repositories/common_question_repositories.dart';

class GetAllCommonQuestion
    extends UseCase<CommonQuestionModel, GetAllCommonQuestionParams> {
  CommonQuestionRepositories commonQuestionRepositories;
  GetAllCommonQuestion({this.commonQuestionRepositories});
  @override
  Future<Either<Failure, CommonQuestionModel>> call(GetAllCommonQuestionParams params) async {
    final finalResult = await commonQuestionRepositories.getAllCommonQuestion();
    return finalResult.fold((failure) => Left(failure), (body) => Right(body));
  }
}

class GetAllCommonQuestionParams {}
