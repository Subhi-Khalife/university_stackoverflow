import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/general_question/data/models/filter_model.dart';
import 'package:university/features/general_question/data/models/general_questions_model.dart';
import 'package:university/features/general_question/data/models/year_semester_model.dart';
import 'package:university/features/post/data/models/posts_model.dart';

abstract class GeneralQuestionRepositories {
  Future<Either<Failure, FilterModel>> getAllFilter();
  Future<Either<Failure, YearSemesterModel>> getYearSemester(Map<String, dynamic> param);
  Future<Either<Failure, GeneralQuestionsModel>> getAllGeneralQuestion({@required Map<String, dynamic> items});
}
