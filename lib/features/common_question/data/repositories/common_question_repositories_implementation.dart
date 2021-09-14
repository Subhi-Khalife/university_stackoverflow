import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/common_question_repositories.dart';
import '../data_sources/remote_gat_all_common_question_for_collage.dart';
import '../data_sources/remote_get_all_common_question.dart';
import '../models/common_question_model.dart';

class CommonQuestionRepositoriesImplementation
    extends CommonQuestionRepositories {
  @override
  Future<Either<Failure, CommonQuestionModel>> getAllCommonQuestion(Map<String,dynamic>param) async {
    final result = await RemoteGetAllCommonQuestion().getAllcommonQuestion(param);
    return result.fold((failure) => Left(failure), (body) => Right(body));
  }

  @override
  Future<Either<Failure, CommonQuestionModel>> getCommonQuestionForCollage(
      String collageID,Map<String,dynamic>param) async {
    final result = await RemoteGetAllCommonQuestionForCollage()
        .getAllCommonQuestionForCollage(collageId: collageID,param: param);
    return result.fold((failure) => Left(failure), (body) => Right(body));
  }
}
