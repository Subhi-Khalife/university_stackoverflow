part of 'general_question_bloc.dart';

abstract class GeneralQuestionEvent extends Equatable {
  const GeneralQuestionEvent();

  @override
  List<Object> get props => [];
}

class GetFilters extends GeneralQuestionEvent {}

class GetYearSemester extends GeneralQuestionEvent {
  final int semesterId;
  final int yearId;
  GetYearSemester({this.semesterId, this.yearId});
}

class FailedGetData extends GeneralQuestionEvent {}

class GetAllGlobalPosts extends GeneralQuestionEvent {
  final bool reloadData;
  GetAllGlobalPosts({this.reloadData=false});
}