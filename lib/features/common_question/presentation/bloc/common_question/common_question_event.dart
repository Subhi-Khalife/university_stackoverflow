part of 'common_question_bloc.dart';

abstract class CommonQuestionEvent extends Equatable {
  const CommonQuestionEvent();

  @override
  List<Object> get props => [];
}

class GetAllCommonQuestionEvent extends CommonQuestionEvent{
}


class GetAllCommonQuestionForSelectedCollageEvent extends CommonQuestionEvent{
  final String collageId;
  GetAllCommonQuestionForSelectedCollageEvent({this.collageId});
}
