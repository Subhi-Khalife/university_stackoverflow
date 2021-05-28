import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/comment/data/models/add_comment_response.dart';
import 'package:university/features/comment/domain/repositories/comment_repositories.dart';

class UpdateCommentUseCase
    extends UseCase<AddCommentResponse, UpdateCommentParams> {
  CommentRepositories commentRepositories;
  UpdateCommentUseCase({this.commentRepositories});
  @override
  Future<Either<Failure, AddCommentResponse>> call(
      UpdateCommentParams params) async {
    final value = await commentRepositories.updateComment(params.getMap());
    return value.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}

class UpdateCommentParams {
  final int commentId;
  final String description;
  UpdateCommentParams({this.commentId, this.description});

  getMap() => {"description": description, "comment_id": commentId};
}
