import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/post/domain/repositories/post_repositories.dart';

class SetNewReactUseCase extends UseCase<bool, SetReactParam> {
  PostRepositories postRepositories;
  SetNewReactUseCase({this.postRepositories});
  @override
  Future<Either<Failure, bool>> call(SetReactParam params) async {
    final _newPostParam = params.getMap();
    final value = await postRepositories.setReact(items: _newPostParam);
    return value.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}

class SetReactParam {
  int postId;
  SetReactParam({
    @required this.postId,
  });
  getMap() => {"post_id": postId, "type": "like"};
}
