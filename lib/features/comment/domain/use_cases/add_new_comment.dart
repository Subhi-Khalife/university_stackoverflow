import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/comment/data/models/add_comment_response.dart';
import 'package:university/features/comment/domain/repositories/comment_repositories.dart';

class AddNewCommentUseCase extends UseCase<AddCommentResponse, AddNewComments> {
  CommentRepositories commentRepositories;
  AddNewCommentUseCase({this.commentRepositories});
  @override
  Future<Either<Failure, AddCommentResponse>> call(
      AddNewComments params) async {
    final value = await commentRepositories.addNewComment(params.getMap());
    return value.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}

class AddNewComments {
  final int commentId;
  final String description;
  final int postId;

  AddNewComments({this.commentId, this.description, this.postId});

  getMap() =>
      {"description": description, "post_id": postId, "comment_id": commentId};
}
