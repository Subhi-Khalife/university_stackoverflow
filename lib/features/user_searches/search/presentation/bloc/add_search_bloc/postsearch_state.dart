part of 'postsearch_bloc.dart';

abstract class PostsearchState extends Equatable {
  const PostsearchState();

  @override
  List<Object> get props => [];
}

class PostsearchInitial extends PostsearchState {}

class LoadingPostsearchState extends PostsearchState {}

class SuccessSendingPostsearchState extends PostsearchState {
  final AddSearchModel addSearchModel;

  SuccessSendingPostsearchState(
    this.addSearchModel,
  );
}

class FailedSendingPostsearchState extends PostsearchState {}
