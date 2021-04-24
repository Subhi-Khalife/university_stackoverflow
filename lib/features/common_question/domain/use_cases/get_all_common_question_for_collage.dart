import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/common_question_model.dart';
import '../repositories/common_question_repositories.dart';

class GetAllCommonQuestionForCollage
    extends UseCase<CommonQuestionModel, GetAllCommonQuestionForCollageParam> {
  CommonQuestionRepositories commonQuestionRepositories;
  GetAllCommonQuestionForCollage({this.commonQuestionRepositories});
  @override
  Future<Either<Failure, CommonQuestionModel>> call(
      GetAllCommonQuestionForCollageParam params) async {
    final finalResult = await commonQuestionRepositories
        .getCommonQuestionForCollage(params.collageId);
    return finalResult.fold((failure) => Left(failure), (body) => Right(body));
  }
}

class GetAllCommonQuestionForCollageParam {
  String collageId;
  GetAllCommonQuestionForCollageParam({this.collageId});
}
