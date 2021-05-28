part of 'postsearch_bloc.dart';

abstract class PostsearchEvent extends Equatable {
  const PostsearchEvent();

  @override
  List<Object> get props => [];
}

class SendingAddSearchEvent extends PostsearchEvent {
  final String searchText;

  SendingAddSearchEvent({
    this.searchText,
  });
}

class SuccessSendingAddSearchsEvent extends PostsearchEvent {}

class FailedSendingAddSearchsEvent extends PostsearchEvent {}
