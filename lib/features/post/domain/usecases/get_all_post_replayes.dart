import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/post/data/models/get_all_replayes_model.dart';
import 'package:university/features/post/domain/repositories/post_repositories.dart';

class GetAllPostReplayesUseCase
    extends UseCase<GetAllReplayesModel, GetAllPostReplayesParam> {
  PostRepositories postRepositories;
  GetAllPostReplayesUseCase({this.postRepositories});
  @override
  Future<Either<Failure, GetAllReplayesModel>> call(
      GetAllPostReplayesParam params) async {
    final _newPostParam = params.getMap();
    final value = await postRepositories.getAllReplayes(items: _newPostParam);
    return value.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}

class GetAllPostReplayesParam {
  int commentId;
  GetAllPostReplayesParam({@required this.commentId});

  Map<String, dynamic> getMap() => {"comment_id": commentId};
}
