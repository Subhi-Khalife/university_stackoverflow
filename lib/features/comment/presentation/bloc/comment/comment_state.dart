part of 'comment_bloc.dart';

abstract class CommentState {
  const CommentState();
}

class CommentInitial extends CommentState {}

class LoadingState extends CommentState {}

class SuccessAddNewComment extends CommentState {
  final Comment addCommentResponse;
  SuccessAddNewComment({this.addCommentResponse});
}

class SuccessUpdateComment extends CommentState {
  final Comment addCommentResponse;
  final int index;
  SuccessUpdateComment({this.addCommentResponse, this.index});
}

class SuccessDeleteComment extends CommentState {
  final int index;
  SuccessDeleteComment({this.index});
}

class Failed extends CommentState {
  final String errorMessage;
  Failed({this.errorMessage});
}

class InvalidCommentState extends CommentState{
  String message;
  InvalidCommentState({this.message});
}
