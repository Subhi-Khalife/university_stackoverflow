import 'package:dartz/dartz.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/unified_api/post_api.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';

class SetNewPost with HandlingExceptionRequest {
  Future<Either<Failure, NewPosts>> setNewPost(Map<String, dynamic> param) async {
    ConstantInfo constantInfo = ConstantInfo.getInstance();
    print("the token is constantInfo.userInfo.token${constantInfo.userInfo.token}");
    final postApi = PostApi<NewPosts>(
        fromJson: newPostsFromJson,
        param: param,
        token: constantInfo.userInfo.token,
        url: "post/create",
        requestName: "Post/Create --> Create New Post ");
    final callRequest = postApi.callRequest;
    Either<Failure, NewPosts> result =
        await handlingExceptionRequest<NewPosts>(requestCall: callRequest);
    return result;
  }
}
