part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class AddNewComment extends CommentEvent {
  final int commentId;
  final String description;
  final int postId;

  AddNewComment({this.commentId, this.description, this.postId});
}

class UpdateComment extends CommentEvent {
  final int commentId;
  final String description;
  final int commentIndex;
  UpdateComment({this.commentId, this.description,this.commentIndex});
}

class DeleteComment extends CommentEvent{
 final int commentId;
 final int commentIndex;

  DeleteComment({this.commentId, this.commentIndex});
}