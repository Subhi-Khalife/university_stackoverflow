import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/general_question/data/data_sources/get_all_general_questions.dart';
import 'package:university/features/general_question/data/data_sources/get_filter_model.dart';
import 'package:university/features/general_question/data/data_sources/get_semantic_year.dart';
import 'package:university/features/general_question/data/models/filter_model.dart';
import 'package:university/features/general_question/data/models/general_questions_model.dart';
import 'package:university/features/general_question/data/models/year_semester_model.dart';
import 'package:university/features/general_question/domain/repositories/general_question_repositories.dart';
import 'package:university/features/post/data/models/posts_model.dart';

class GeneralQuestionRepositoriesImplementation implements GeneralQuestionRepositories {
  @override
  Future<Either<Failure, FilterModel>> getAllFilter() async {
    GetFiltters getFiltters = GetFiltters();
    Either<Failure, FilterModel> value = await getFiltters.getAllFilters();
    return value;
  }

  @override
  Future<Either<Failure, YearSemesterModel>> getYearSemester(Map<String, dynamic> param) async {
    GetSemanticYear getSemanticYear = GetSemanticYear();
    Either<Failure, YearSemesterModel> value = await getSemanticYear.getSemanticYear(param);
    return value;
  }

  @override
  Future<Either<Failure, GeneralQuestionsModel>> getAllGeneralQuestion({Map<String, dynamic> items}) async {
    GetAllGeneralQuetion getAllPosts = new GetAllGeneralQuetion();
    Either<Failure, GeneralQuestionsModel> item = await getAllPosts.getAllGeneralQuetion(items);
    return item;
  }
}
