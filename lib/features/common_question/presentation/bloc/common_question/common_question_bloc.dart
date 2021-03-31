import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:university/core/entities/common_question.dart';
import 'package:university/core/error/exception.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/common_question/data/models/common_question_model.dart';
import 'package:university/features/common_question/data/repositories/common_question_repositories_implementation.dart';
import 'package:university/features/common_question/domain/use_cases/get_all_common_question.dart';
import 'package:university/features/common_question/domain/use_cases/get_all_common_question_for_collage.dart';

part 'common_question_event.dart';
part 'common_question_state.dart';

class CommonQuestionBloc
    extends Bloc<CommonQuestionEvent, CommonQuestionState> {
  CommonQuestionBloc() : super(CommonQuestionInitial());
  UseCase getAllCommonQuestion = GetAllCommonQuestion(
      commonQuestionRepositories: CommonQuestionRepositoriesImplementation());
  UseCase getAllCommonQuestionForCollage = GetAllCommonQuestionForCollage(
      commonQuestionRepositories: CommonQuestionRepositoriesImplementation());
  
  
  @override
  Stream<CommonQuestionState> mapEventToState(
      CommonQuestionEvent event) async* {
    if (event is GetAllCommonQuestionEvent) {
      yield* _mapGetAllCommonQuestionEvent();
    }
    else if(event is GetAllCommonQuestionForSelectedCollageEvent)
    {
yield * _mapGetAllCommonQuestionForSelectedCollageEvent(event);
    }
  }

  Stream<CommonQuestionState> _mapGetAllCommonQuestionForSelectedCollageEvent(GetAllCommonQuestionForSelectedCollageEvent event) async* {
    yield LoadingState();
    final result = await getAllCommonQuestionForCollage(GetAllCommonQuestionForCollageParam(collageId: event.collageId));
    yield result.fold(
      (failure) {
        if (failure is MissingParamException)
          return GetAllCommonQuestionFailed();
        else {
          return GetAllCommonQuestionFailed();
        }
      },
      (body) {
        CommonQuestionModel model = body;
        return GetAllCommonQuestionSuccess(commonItemsList: model.data);
      },
    );
  }

  Stream<CommonQuestionState> _mapGetAllCommonQuestionEvent() async* {
    yield LoadingState();
    final result = await getAllCommonQuestion(null);
    yield result.fold(
      (failure) {
        if (failure is MissingParamException)
          return GetAllCommonQuestionFailed();
        else {
          return GetAllCommonQuestionFailed();
        }
      },
      (body) {
        CommonQuestionModel model = body;
        return GetAllCommonQuestionSuccess(commonItemsList: model.data);
      },
    );
  }
}
