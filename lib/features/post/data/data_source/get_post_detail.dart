import 'package:dartz/dartz.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/unified_api/get_api.dart';
import 'package:university/core/unified_api/post_api.dart';
import 'package:university/features/post/data/models/post_detail_model.dart';
import 'package:university/features/post/data/models/taps_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';

class GetPostDetailApi with HandlingExceptionRequest {
  Future<Either<Failure, PostDetailModel>> getPostDetail(
      Map<String, dynamic> map) async {
    ConstantInfo constantInfo = ConstantInfo.getInstance();
    print("The map Value isdsadas $map");
    final postApi = GetApi<PostDetailModel>(
        token: constantInfo.userInfo.token,
        fromJson: postDetailModelFromJson,
        url: "post/find",
        requestName: "Get Post Details",
        param: map);
    final callRequest = postApi.callRequest;
    Either<Failure, PostDetailModel> result =
        await handlingExceptionRequest<PostDetailModel>(
            requestCall: callRequest);
    return result;
  }
}
