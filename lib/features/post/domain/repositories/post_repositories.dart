import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/post/data/models/get_all_replayes_model.dart';
import 'package:university/features/post/data/models/post_detail_model.dart';
import 'package:university/features/post/data/models/posts_model.dart';
import 'package:university/features/post/data/models/taps_model.dart';
import 'package:university/features/post/presentation/bloc/post/post_bloc.dart';

abstract class PostRepositories {
  Future<Either<Failure, NewPosts>> setNewPost(
      {@required Map<String, dynamic> items});

  Future<Either<Failure, TapsModel>> getAllTaps();

  Future<Either<Failure, PostsModel>> getPostsForSelectedTags(
      {@required Map<String, dynamic> items});

  Future<Either<Failure, String>> uploadImage({@required File items});

  Future<Either<Failure, PostDetailModel>> getPostDetail(
      {@required Map<String, dynamic> items});

  
  Future<Either<Failure, GetAllReplayesModel>> getAllReplayes(
      {@required Map<String, dynamic> items});

    Future<Either<Failure, bool>> setReact(
      {@required Map<String, dynamic> items});
}
