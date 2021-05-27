import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:university/features/post/data/data_source/get_all_post_replayes.dart';
import 'package:university/features/post/data/data_source/get_all_tabs.dart';
import 'package:university/features/post/data/data_source/get_post_detail.dart';
import 'package:university/features/post/data/data_source/get_posts_for_selected_tags.dart';
import 'package:university/features/post/data/data_source/set_new_post.dart';
import 'package:university/features/post/data/data_source/upload_image.dart';
import 'package:university/features/post/data/models/get_all_replayes_model.dart';
import 'package:university/features/post/data/models/post_detail_model.dart';
import 'package:university/features/post/data/models/posts_model.dart';
import 'package:university/features/post/data/models/taps_model.dart';
import 'package:university/features/post/domain/repositories/post_repositories.dart';
import 'package:university/features/post/presentation/bloc/post/post_bloc.dart';

class PostRepositoriesImplementation implements PostRepositories {
  @override
  Future<Either<Failure, NewPosts>> setNewPost(
      {Map<String, dynamic> items}) async {
    SetNewPost setNewPost = new SetNewPost();
    Either<Failure, NewPosts> item = await setNewPost.setNewPost(items);
    return item;
  }

  @override
  Future<Either<Failure, TapsModel>> getAllTaps() async {
    GetAllTaps getAllPosts = new GetAllTaps();
    Either<Failure, TapsModel> item = await getAllPosts.getAllTabs();
    return item;
  }

  @override
  Future<Either<Failure, PostsModel>> getPostsForSelectedTags(
      {Map<String, dynamic> items}) async {
    GetAllPostsForSelectedTaps posts = new GetAllPostsForSelectedTaps();
    Either<Failure, PostsModel> item = await posts.getAllPosts(items);
    return item;
  }

  @override
  Future<Either<Failure, String>> uploadImage({File items}) async {
    RemoteUploadImage posts = new RemoteUploadImage();
    Either<Failure, String> item = await posts.setNewImage(items);
    return item;
  }

  @override
  Future<Either<Failure, PostDetailModel>> getPostDetail(
      {@required Map<String, dynamic> items}) async {
    GetPostDetailApi getPostDetail = new GetPostDetailApi();
    Either<Failure, PostDetailModel> item =
        await getPostDetail.getPostDetail(items);
    return item;
  }

  @override
  Future<Either<Failure, GetAllReplayesModel>> getAllReplayes(
      {Map<String, dynamic> items}) async {
    GetAllPostReplayes getAllPostReplayes = new GetAllPostReplayes();
    Either<Failure, GetAllReplayesModel> item = await getAllPostReplayes.getAllPostReplayes(items);
    return item;
  }
}
