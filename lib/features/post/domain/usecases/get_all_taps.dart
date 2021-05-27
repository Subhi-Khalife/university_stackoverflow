import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/post/data/models/taps_model.dart';
import 'package:university/features/post/domain/repositories/post_repositories.dart';

class GetAllTapsCase extends UseCase<TapsModel, GetALLTapsParam> {
  PostRepositories postRepositories;
  GetAllTapsCase({this.postRepositories});
  @override
  Future<Either<Failure, TapsModel>> call(GetALLTapsParam params) async {
    final value = await postRepositories.getAllTaps();
    return value.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}

class GetALLTapsParam {}
