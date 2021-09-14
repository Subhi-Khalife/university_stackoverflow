import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/use_case/use_case.dart';
import '../../../data/models/search_model.dart';
import '../../../data/repositories/search_repository_impl.dart';
import '../../../domain/usecases/search_usecase.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());
  UseCase getAds = SearchUseCase(
    searchRepository: SearchRepositoryImpl(),
  );

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is FetchingSearchInfoEvent) {
      yield LoadingSearchInfoState();
      Either<Failure, SearchModel> result = await getAds(null);
      yield result.fold(
        (failure) => FailedGettingSearchInfoState(),
        (successSearchsModel) =>
            SuccessGettingSearchInfoState(successSearchsModel),
      );
    }
  }
}
