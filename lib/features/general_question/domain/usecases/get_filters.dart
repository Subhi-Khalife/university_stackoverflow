import 'package:dartz/dartz.dart';
import 'package:university/features/general_question/data/models/filter_model.dart';
import 'package:university/features/general_question/domain/repositories/general_question_repositories.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';

class GetFiltersUseCase extends UseCase<FilterModel, GetFiltersUseCaseParam> {
  GeneralQuestionRepositories commonQuestionRepositories;
  GetFiltersUseCase({this.commonQuestionRepositories});
  @override
  Future<Either<Failure, FilterModel>> call(GetFiltersUseCaseParam params) async {
    final finalResult = await commonQuestionRepositories.getAllFilter();
    return finalResult.fold((failure) => Left(failure), (body) => Right(body));
  }
}

class GetFiltersUseCaseParam {}
