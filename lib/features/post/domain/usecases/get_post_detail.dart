import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/post/data/models/post_detail_model.dart';
import 'package:university/features/post/domain/repositories/post_repositories.dart';

class GetPostDetailUseCase extends UseCase<PostDetailModel, GetPostDetailParam> {
  PostRepositories postRepositories;
  GetPostDetailUseCase({this.postRepositories});
  @override
  Future<Either<Failure, PostDetailModel>> call(GetPostDetailParam params) async {
    final _newPostParam = params.getMap();
    final value = await postRepositories.getPostDetail(items: _newPostParam);
    return value.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}

class GetPostDetailParam {
  int postID;
  GetPostDetailParam({@required this.postID});

  Map<String, dynamic> getMap() => {"post_id": postID};
}
