import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/comment/data/data_sources/add_new_comment.dart';
import 'package:university/features/comment/data/data_sources/add_new_replay.dart';
import 'package:university/features/comment/data/data_sources/delete_comment.dart';
import 'package:university/features/comment/data/data_sources/update_comment.dart';
import 'package:university/features/comment/data/models/add_comment_response.dart';
import 'package:university/features/comment/domain/repositories/comment_repositories.dart';

class CommentRepositoriesImplemintation implements CommentRepositories {
  @override
  Future<Either<Failure, AddCommentResponse>> addNewComment(
      Map<String, dynamic> param) async {
    AddNewComment addNewComment = AddNewComment();
    final result = await addNewComment.setNewComment(param);
    return result;
  }

  @override
  Future<Either<Failure, AddCommentResponse>> updateComment(
      Map<String, dynamic> param) async {
    UpdateComment updateComment = UpdateComment();
    final result = await updateComment.updateComment(param);
    return result;
  }

  @override
  Future<Either<Failure, bool>> deleteComment(int commentId) async {
    DeleteComment deleteComment = DeleteComment();
    final result = await deleteComment.deleteComment(commentId);
    return result;
  }

  @override
  Future<Either<Failure, AddCommentResponse>> addNewReplay(
      Map<String, dynamic> param) async {
    AddNewReplay addNewComment = AddNewReplay();
    final result = await addNewComment.setNewComment(param);
    return result;
  }
}
