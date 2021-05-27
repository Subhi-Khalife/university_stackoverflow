import 'package:dartz/dartz.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/unified_api/get_api.dart';
import 'package:university/core/unified_api/post_api.dart';
import 'package:university/features/post/data/models/posts_model.dart';
import 'package:university/features/post/data/models/taps_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';

class GetAllPostsForSelectedTaps with HandlingExceptionRequest {
  Future<Either<Failure, PostsModel>> getAllPosts(
      Map<String, dynamic> items) async {
    ConstantInfo constantInfo = ConstantInfo.getInstance();

    int tabId = items["tab_id"];
    final postApi = GetApi<PostsModel>(
        token: constantInfo.userInfo.token,
        fromJson: postsModelFromJson,
        url: "post/get?tab_id=$tabId",
        requestName: "Get Posts for selected Tags");
    final callRequest = postApi.callRequest;
    Either<Failure, PostsModel> result =
        await handlingExceptionRequest<PostsModel>(requestCall: callRequest);
    return result;
  }
}
