import 'package:university/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/common_question/data/models/common_question_model.dart';
import 'package:university/features/common_question/domain/repositories/common_question_repositories.dart';

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
