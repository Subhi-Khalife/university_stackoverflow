import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/error/exception.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/post/data/models/taps_model.dart';
import 'package:university/features/post/data/repositories/post_repositories_impl.dart';
import 'package:university/features/post/domain/usecases/get_all_taps.dart';

part 'tabs_event.dart';
part 'tabs_state.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState> {
  TabsBloc() : super(TabsInitial());
  UseCase getAllTaps =
      GetAllTapsCase(postRepositories: PostRepositoriesImplementation());

  @override
  Stream<TabsState> mapEventToState(TabsEvent event) async* {
    if (event is GetAllTaps) {
      yield* _mapGetAllTaps(event);
    }
  }

  Stream<TabsState> _mapGetAllTaps(GetAllTaps event) async* {
    yield LoadingState();
    Either<Failure, TapsModel> result = await getAllTaps(GetALLTapsParam());
    yield result.fold((failure) {
      if (failure is MissingParamException)
        return FailedGetAllTabs();
      else {
        return FailedGetAllTabs();
      }
    }, (body) {
      return SuccessGetAllTabs(taps: body.data);
    });
  }
}
