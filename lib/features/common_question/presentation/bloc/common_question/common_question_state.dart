part of 'common_question_bloc.dart';

abstract class CommonQuestionState  {
  const CommonQuestionState();
  
}

class CommonQuestionInitial extends CommonQuestionState {}


class GetAllCommonQuestionFailed extends CommonQuestionState{}

class GetAllCommonQuestionSuccess extends CommonQuestionState{
  final List<CommonQuestion> commonItemsList;
  GetAllCommonQuestionSuccess({@required this.commonItemsList});
}

class LoadingState extends CommonQuestionState{}