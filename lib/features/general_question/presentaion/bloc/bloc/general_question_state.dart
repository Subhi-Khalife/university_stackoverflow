part of 'general_question_bloc.dart';

enum GeneralQuestionStatus { failed, initail, success, loading }

class GeneralQuestionState {
  GeneralQuestionStatus status;
  List<GeneralQuestionsList> posts;
  bool hasReachedMax;
  GeneralQuestionState({
    this.status = GeneralQuestionStatus.initail,
    this.posts = const <GeneralQuestionsList>[],
    this.hasReachedMax = false,
  });

  copyWith(
      {GeneralQuestionStatus status, List<GeneralQuestionsList> posts, bool hasReachedMax}) {
    return GeneralQuestionState(
        status: (status) ?? this.status,
        posts: (posts) ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }
}


class LoadingStateGeneralQuestion extends GeneralQuestionState {}

class FailedGetAllFilter extends GeneralQuestionState {}

class SuccessGetAllFilter extends GeneralQuestionState {
  final FilterModel filterModel;
  SuccessGetAllFilter({this.filterModel});
}

class SuccessGetAllYearSemantic extends GeneralQuestionState {
  final YearSemesterModel searSemesterModel;
  SuccessGetAllYearSemantic({this.searSemesterModel});
}
