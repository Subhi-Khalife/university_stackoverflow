import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/user_searches/search/data/models/del_search_model.dart';
import 'package:university/features/user_searches/search/data/repositories/del_search_repo_impl.dart';
import 'package:university/features/user_searches/search/domain/usecases/del_search_usecase.dart';

part 'delete_event.dart';

part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  DeleteBloc() : super(DeleteInitial());

  UseCase sendSearchs = DelSearchUsecase(
    delSearchRepository: DelSearchRepoImpl(),
  );

  @override
  Stream<DeleteState> mapEventToState(
    DeleteEvent event,
  ) async* {
    if (event is SendingDelSearchEvent) {
      yield LoadingDelSearchState();
      Either<Failure, DelSearchModel> result = await sendSearchs(
        GetDelSearchParam(),
      );
      yield result.fold(
        (failure) => FailedSendingDelSearchState(),
        (successDelSearchModel) =>
            SuccessSendingDelSearchState(successDelSearchModel),
      );
    }
  }
}
