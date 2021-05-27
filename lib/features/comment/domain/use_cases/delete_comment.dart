import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/comment/domain/repositories/comment_repositories.dart';

class DeleteCommentUseCase extends UseCase<bool, int> {
  CommentRepositories commentRepositories;
  DeleteCommentUseCase({this.commentRepositories});
  @override
  Future<Either<Failure, bool>> call(int params) async {
    final value = await commentRepositories.deleteComment(params);
    return value.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}
