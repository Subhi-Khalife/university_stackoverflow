import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/entities/post.dart';
import 'package:university/core/error/exception.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/general_question/data/models/filter_model.dart';
import 'package:university/features/general_question/data/models/general_questions_model.dart';
import 'package:university/features/general_question/data/models/year_semester_model.dart';
import 'package:university/features/general_question/data/repositories/general_question_repositories_implementation.dart';
import 'package:university/features/general_question/domain/usecases/get_all_general_questions.dart';
import 'package:university/features/general_question/domain/usecases/get_filters.dart';
import 'package:rxdart/rxdart.dart';
import 'package:university/features/general_question/domain/usecases/get_year_semester.dart';
import 'package:university/features/post/data/models/posts_model.dart';
part 'general_question_event.dart';
part 'general_question_state.dart';

class GeneralQuestionBloc extends Bloc<GeneralQuestionEvent, GeneralQuestionState> {
  final int pageSize = 9;

  GeneralQuestionBloc() : super(GeneralQuestionState());
  UseCase<FilterModel, GetFiltersUseCaseParam> getFilters =
      GetFiltersUseCase(commonQuestionRepositories: GeneralQuestionRepositoriesImplementation());
  UseCase<YearSemesterModel, GetYearSemesterUseCaseParam> getYearSemantic = GetYearSemesterUseCase(
      generalQuestionRepositories: GeneralQuestionRepositoriesImplementation());
  UseCase<GeneralQuestionsModel, GetAllGeneralQestionsParams> getAllGeneralQestionsParams =
      GetAllGeneralQestions(
          generalQuestionRepositories: GeneralQuestionRepositoriesImplementation());
  @override
  Stream<Transition<GeneralQuestionEvent, GeneralQuestionState>> transformEvents(
    Stream<GeneralQuestionEvent> events,
    TransitionFunction<GeneralQuestionEvent, GeneralQuestionState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<GeneralQuestionState> mapEventToState(
    GeneralQuestionEvent event,
  ) async* {
    if (event is GetFilters) {
      yield* _mapGetFilters();
    } else if (event is GetYearSemester) {
      yield* _mapGetYearSemester(event);
    } else if (event is GetAllGlobalPosts) {
      yield* _mapGetPostForSelectedTags(event, state);
    }
  }

  Stream<GeneralQuestionState> _mapGetPostForSelectedTags(
      GetAllGlobalPosts event, GeneralQuestionState state) async* {
    try {
      if (event.reloadData) {
        state = GeneralQuestionState();
        yield state;
      }
      if (state.hasReachedMax) {
        yield state;
        return;
      }
      if (state.posts.length == 0) yield state.copyWith(status: GeneralQuestionStatus.loading);
      final array = await _fetchData(state.posts.length ~/ pageSize);
      if (array == null) {
        yield state.copyWith(
          status: GeneralQuestionStatus.failed,
        );
        return;
      } else {
        List<GeneralQuestionsList> commonItemsList = state.posts;
        if (commonItemsList.length == 0) {
          yield state.copyWith(
              posts: array,
              hasReachedMax: hasReachedMax(array.length),
              status: GeneralQuestionStatus.success);
          return;
        }
        for (int i = 0; i < array.length; i++) commonItemsList.add(array[i]);
        yield state.copyWith(
            posts: commonItemsList,
            hasReachedMax: hasReachedMax(array.length),
            status: GeneralQuestionStatus.success);
      }
    } catch (e) {
      yield state.copyWith(status: GeneralQuestionStatus.failed);
    }
  }

  Future<List<GeneralQuestionsList>> _fetchData(int page) async {
    Either<Failure, GeneralQuestionsModel> result =
        await getAllGeneralQestionsParams(GetAllGeneralQestionsParams(pageNumber: page));
    return result.fold((failure) {
      if (failure is MissingParamException)
        return null;
      else {
        return null;
      }
    }, (body) {
      return body.data;
    });
  }

  Stream<GeneralQuestionState> _mapGetYearSemester(GetYearSemester event) async* {
    yield LoadingStateGeneralQuestion();
    final result = await getYearSemantic(GetYearSemesterUseCaseParam(
      semesterId: event.semesterId,
      yearId: event.yearId,
    ));
    yield result.fold(
      (failure) {
        if (failure is MissingParamException)
          return FailedGetAllFilter();
        else {
          return FailedGetAllFilter();
        }
      },
      (body) {
        return SuccessGetAllYearSemantic(searSemesterModel: body);
      },
    );
  }

  Stream<GeneralQuestionState> _mapGetFilters() async* {
    yield LoadingStateGeneralQuestion();
    final result = await getFilters(GetFiltersUseCaseParam());
    yield result.fold(
      (failure) {
        if (failure is MissingParamException)
          return FailedGetAllFilter();
        else {
          return FailedGetAllFilter();
        }
      },
      (body) {
        return SuccessGetAllFilter(filterModel: body);
      },
    );
  }

  bool hasReachedMax(int number) {
    return true;
  }
}
