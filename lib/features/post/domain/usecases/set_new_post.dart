import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/post/domain/repositories/post_repositories.dart';

class SetNewPost extends UseCase<NewPosts, SetNewPostParam> {
  PostRepositories postRepositories;
  SetNewPost({this.postRepositories});
  @override
  Future<Either<Failure, NewPosts>> call(SetNewPostParam params) async {
    final _newPostParam = params.getMap();
    final value = await postRepositories.setNewPost(items: _newPostParam);
    return value.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}

class SetNewPostParam {
  String title;
  String description;
  int tapID;
  SetNewPostParam(
      {@required this.description, @required this.tapID, @required this.title});

  Map<String, dynamic> getMap() =>
      {"title": title, "description": description, "tab_id": tapID};
}
