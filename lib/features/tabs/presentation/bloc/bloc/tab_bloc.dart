import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';

import 'package:university/features/tabs/data/models/tab_model.dart';
import 'package:university/features/tabs/data/repositories/tabs_repo_impl.dart';
import 'package:university/features/tabs/domain/usecases/tabs_usecase.dart';

part 'tab_event.dart';

part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitial());

  UseCase getTabs = TabsUsecase(
    tabsRepository: TabsRepoImpl(),
  );

  @override
  Stream<TabState> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is FetchTabsEvent) {
      yield LoadingGettingTabsState();
      Either<Failure, TabModel> result = await getTabs(GetTabsParam());
      yield result.fold(
        (failure) => FailedGettingTabsState(),
        (successTabsModel) => SuccessGettingTabsState(successTabsModel),
      );
    }
  }
}
