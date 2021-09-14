import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/general_question/data/models/general_questions_model.dart';
import 'package:university/features/general_question/domain/repositories/general_question_repositories.dart';
import 'package:university/features/post/data/models/posts_model.dart';
import 'package:university/features/post/domain/repositories/post_repositories.dart';

class GetAllGeneralQestions extends UseCase<GeneralQuestionsModel, GetAllGeneralQestionsParams> {
  GeneralQuestionRepositories generalQuestionRepositories;
  GetAllGeneralQestions({this.generalQuestionRepositories});
  @override
  Future<Either<Failure, GeneralQuestionsModel>> call(GetAllGeneralQestionsParams params) async {
    final _newPostParam = params.getMap();
    final value = await generalQuestionRepositories.getAllGeneralQuestion(items: _newPostParam);
    return value.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}

class GetAllGeneralQestionsParams {
  int pageNumber;
  GetAllGeneralQestionsParams({ this.pageNumber});

  Map<String, dynamic> getMap() {
    if (pageNumber == 0) {
      return {
      };
    } else {
      return { "page": pageNumber};
    }
  }
}
