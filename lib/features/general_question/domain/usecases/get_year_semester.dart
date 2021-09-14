import 'package:dartz/dartz.dart';
import 'package:university/features/general_question/data/models/year_semester_model.dart';
import 'package:university/features/general_question/domain/repositories/general_question_repositories.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';

class GetYearSemesterUseCase extends UseCase<YearSemesterModel, GetYearSemesterUseCaseParam> {
  GeneralQuestionRepositories generalQuestionRepositories;
  GetYearSemesterUseCase({this.generalQuestionRepositories});
  @override
  Future<Either<Failure, YearSemesterModel>> call(GetYearSemesterUseCaseParam params) async {
    final finalResult = await generalQuestionRepositories.getYearSemester(params.getParam());
    return finalResult.fold((failure) => Left(failure), (body) => Right(body));
  }
}

class GetYearSemesterUseCaseParam {
  int semesterId;
  int yearId;
  GetYearSemesterUseCaseParam({this.semesterId, this.yearId});

  Map<String, dynamic> getParam() => {
        "semester_id": semesterId,
        "year_id": yearId,
      };
}
