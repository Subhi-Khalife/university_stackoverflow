import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/common_question_model.dart';
import '../repositories/common_question_repositories.dart';

class GetAllCommonQuestion
    extends UseCase<CommonQuestionModel, GetAllCommonQuestionParams> {
  CommonQuestionRepositories commonQuestionRepositories;
  GetAllCommonQuestion({this.commonQuestionRepositories});
  @override
  Future<Either<Failure, CommonQuestionModel>> call(
      GetAllCommonQuestionParams params) async {
    final val = params.pageNumber == 0 ? null : params.getParam();
    final finalResult =
        await commonQuestionRepositories.getAllCommonQuestion(val);
    return finalResult.fold((failure) => Left(failure), (body) => Right(body));
  }
}

class GetAllCommonQuestionParams {
  int pageNumber;
  GetAllCommonQuestionParams({this.pageNumber});
  Map<String, dynamic> getParam() => {"page": pageNumber};
}
