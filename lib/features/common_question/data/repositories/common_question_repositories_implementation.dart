import 'package:university/features/common_question/data/data_sources/remote_gat_all_common_question_for_collage.dart';
import 'package:university/features/common_question/data/data_sources/remote_get_all_common_question.dart';
import 'package:university/features/common_question/data/models/common_question_model.dart';
import 'package:university/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:university/features/common_question/domain/repositories/common_question_repositories.dart';

class CommonQuestionRepositoriesImplementation
    extends CommonQuestionRepositories {
  @override
  Future<Either<Failure, CommonQuestionModel>> getAllCommonQuestion() async {
    final result = await RemoteGetAllCommonQuestion().getAllcommonQuestion();
    return result.fold((failure) => Left(failure), (body) => Right(body));
  }

  @override
  Future<Either<Failure, CommonQuestionModel>> getCommonQuestionForCollage(
      String collageID) async {
    final result = await RemoteGetAllCommonQuestionForCollage()
        .getAllCommonQuestionForCollage(collageId: collageID);
    return result.fold((failure) => Left(failure), (body) => Right(body));
  }
}
