import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/comment/data/models/add_comment_response.dart';

abstract class CommentRepositories {
  Future<Either<Failure, AddCommentResponse>> addNewComment(
      Map<String, dynamic> param);

  Future<Either<Failure, AddCommentResponse>> updateComment(
      Map<String, dynamic> param);

  Future<Either<Failure, bool>> deleteComment(int commentId);
}
