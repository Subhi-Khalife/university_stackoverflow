import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/entities/common_question.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../data/models/common_question_model.dart';
import '../../../data/repositories/common_question_repositories_implementation.dart';
import '../../../domain/use_cases/get_all_common_question.dart';
import '../../../domain/use_cases/get_all_common_question_for_collage.dart';
import 'package:rxdart/rxdart.dart';
part 'common_question_event.dart';
part 'common_question_state.dart';

class CommonQuestionBloc
    extends Bloc<CommonQuestionEvent, CommonQuestionState> {
  final int pageSize = 6;
  CommonQuestionBloc() : super(CommonQuestionState());
  UseCase getAllCommonQuestion = GetAllCommonQuestion(
      commonQuestionRepositories: CommonQuestionRepositoriesImplementation());
  UseCase getAllCommonQuestionForCollage = GetAllCommonQuestionForCollage(
      commonQuestionRepositories: CommonQuestionRepositoriesImplementation());

  @override
  Stream<Transition<CommonQuestionEvent, CommonQuestionState>> transformEvents(
    Stream<CommonQuestionEvent> events,
    TransitionFunction<CommonQuestionEvent, CommonQuestionState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 200)),
      transitionFn,
    );
  }

  @override
  Stream<CommonQuestionState> mapEventToState(
      CommonQuestionEvent event) async* {
    if (event is GetAllCommonQuestionEvent) {
      yield* _mapGetAllCommonQuestionEvent(event);
    } else if (event is GetAllCommonQuestionForSelectedCollageEvent) {
      yield* _mapGetAllCommonQuestionForSelectedCollageEvent(event, state);
    }
  }

  Stream<CommonQuestionState> _mapGetAllCommonQuestionForSelectedCollageEvent(
      GetAllCommonQuestionForSelectedCollageEvent event,
      CommonQuestionState state) async* {
    try {
      if (event.reloadData) {
        state = CommonQuestionState();
        yield state;
      }
      if (state.commonItemsList.length == 0)
        yield state.copyWith(status: CommonQuestionStatus.loading);
      if (state.hasReachedMax == true) {
        yield state;
        return;
      }
      print("state.commonItemsList.length ${state.commonItemsList.length}");
      final array = await _fetchUniversityCommonQuestionData(
          event.collageId, state.commonItemsList.length ~/ pageSize);
      if (array == null) {
        yield state.copyWith(
          status: CommonQuestionStatus.error,
        );
        return;
      } else {
        List<CommonQuestion> commonItemsList = state.commonItemsList;
        if (commonItemsList.length == 0) {
          yield state.copyWith(
              commonItemsList: array,
              hasReachedMax: hasReachedMax(array.length),
              status: CommonQuestionStatus.success);
          return;
        }
        for (int i = 0; i < array.length; i++) commonItemsList.add(array[i]);
        yield state.copyWith(
            commonItemsList: commonItemsList,
            hasReachedMax: hasReachedMax(array.length),
            status: CommonQuestionStatus.success);
      }
    } catch (e) {
      print("the error is $e");
      yield state.copyWith(status: CommonQuestionStatus.error);
    }
  }

  Stream<CommonQuestionState> _mapGetAllCommonQuestionEvent(GetAllCommonQuestionEvent event) async* {
    try {
      if(event.reloadData){
        yield state.copyWith(status: CommonQuestionStatus.loading,commonItemsList: [],hasReachedMax: false);
      }
      if (state.commonItemsList.length == 0)
        yield state.copyWith(status: CommonQuestionStatus.loading);
      if (state.hasReachedMax == true) {
        yield state;
        return;
      }
      final array = await _fetchGlobalCommonQuestionData(
          state.commonItemsList.length ~/ pageSize);
      if (array == null) {
        yield state.copyWith(
          status: CommonQuestionStatus.error,
        );
        return;
      } else {
        List<CommonQuestion> commonItemsList = state.commonItemsList;
        if (commonItemsList.length == 0) {
          yield state.copyWith(
              commonItemsList: array,
              hasReachedMax: hasReachedMax(array.length),
              status: CommonQuestionStatus.success);
          return;
        }
        for (int i = 0; i < array.length; i++) commonItemsList.add(array[i]);
        yield state.copyWith(
            commonItemsList: commonItemsList,
            hasReachedMax: hasReachedMax(array.length),
            status: CommonQuestionStatus.success);
      }
    } catch (e) {
      print("the error is $e");
      yield state.copyWith(status: CommonQuestionStatus.error);
    }
  }

  Future<List<CommonQuestion>> _fetchGlobalCommonQuestionData(
      [int currentPage = 0]) async {
    final result = await getAllCommonQuestion(
        GetAllCommonQuestionParams(pageNumber: currentPage));
    return result.fold(
      (failure) {
        if (failure is MissingParamException)
          return null;
        else {
          return null;
        }
      },
      (body) {
        CommonQuestionModel model = body;
        return model.data.data;
      },
    );

    // final result = await getAllCommonQuestionForCollage(
    //       GetAllCommonQuestionForCollageParam(collageId: event.collageId));

    // yield result.fold(
    //   (failure) {
    //     if (failure is MissingParamException)
    //       return GetAllCommonQuestionFailed();
    //     else {
    //       return GetAllCommonQuestionFailed();
    //     }
    //   },
    //   (body) {
    //     CommonQuestionModel model = body;
    //     return GetAllCommonQuestionSuccess(commonItemsList: model.data.data);
    //   },
    // );
  }

  Future<List<CommonQuestion>> _fetchUniversityCommonQuestionData(
      String collageId,
      [int currentPage = 0]) async {
    final result = await getAllCommonQuestionForCollage(
        GetAllCommonQuestionForCollageParam(
            collageId: collageId, pageNumber: currentPage));
    return result.fold(
      (failure) {
        if (failure is MissingParamException)
          return null;
        else {
          return null;
        }
      },
      (body) {
        CommonQuestionModel model = body;
        return model.data.data;
      },
    );

    // yield result.fold(
    //   (failure) {
    //     if (failure is MissingParamException)
    //       return GetAllCommonQuestionFailed();
    //     else {
    //       return GetAllCommonQuestionFailed();
    //     }
    //   },
    //   (body) {
    //     CommonQuestionModel model = body;
    //     return GetAllCommonQuestionSuccess(commonItemsList: model.data.data);
    //   },
    // );
  }

  bool hasReachedMax(int number) {
    print("the number is $number and ");
    return number < pageSize;
  }
}
