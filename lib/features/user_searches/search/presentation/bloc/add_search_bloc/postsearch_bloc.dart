import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/user_searches/search/data/models/add_search_model.dart';
import 'package:university/features/user_searches/search/data/repositories/add_search_repo_impl.dart';
import 'package:university/features/user_searches/search/domain/usecases/add_search_usecase.dart';

part 'postsearch_event.dart';

part 'postsearch_state.dart';

class PostsearchBloc extends Bloc<PostsearchEvent, PostsearchState> {
  PostsearchBloc() : super(PostsearchInitial());

  UseCase sendSearchs = AddSearchUsecase(
    addSearchRepository: AddSearchRepoImpl(),
  );

  @override
  Stream<PostsearchState> mapEventToState(
    PostsearchEvent event,
  ) async* {
    if (event is SendingAddSearchEvent) {
      yield LoadingPostsearchState();
      Either<Failure, AddSearchModel> result = await sendSearchs(
        GetPostSearchsParam(
          searchText: event.searchText,
        ),
      );
      yield result.fold(
        (failure) => FailedSendingPostsearchState(),
        (successPostSearchModel) =>
            SuccessSendingPostsearchState(successPostSearchModel),
      );
    }

    // TODO: implement mapEventToState
  }
}
