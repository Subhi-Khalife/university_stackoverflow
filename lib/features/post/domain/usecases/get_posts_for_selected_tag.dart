import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/post/data/models/posts_model.dart';
import 'package:university/features/post/domain/repositories/post_repositories.dart';

class GetPostsForSelectedTags extends UseCase<PostsModel, GetPostsForSelectedTagsParams> {
  PostRepositories postRepositories;
  GetPostsForSelectedTags({this.postRepositories});
  @override
  Future<Either<Failure, PostsModel>> call(GetPostsForSelectedTagsParams params) async {
    final _newPostParam = params.getMap();
    final value = await postRepositories.getPostsForSelectedTags(items: _newPostParam);
    return value.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}

class GetPostsForSelectedTagsParams {
  int tabId;
  GetPostsForSelectedTagsParams({@required this.tabId});

  Map<String, dynamic> getMap() => {"tab_id": tabId};
}
