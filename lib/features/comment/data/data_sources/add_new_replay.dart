import 'package:dartz/dartz.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/unified_api/post_api.dart';
import 'package:university/features/comment/data/models/add_comment_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';

class AddNewReplay with HandlingExceptionRequest {
  Future<Either<Failure, AddCommentResponse>> setNewComment(
      Map<String, dynamic> param) async {
    ConstantInfo constantInfo = ConstantInfo.getInstance();
    final postApi = PostApi<AddCommentResponse>(
        fromJson: addCommentResponseFromJson,
        param: param,
        token: constantInfo.userInfo.token,
        url: "comment/create",
        requestName: "comment/create --> Create New Comment ");
    final callRequest = postApi.callRequest;
    Either<Failure, AddCommentResponse> result =
        await handlingExceptionRequest<AddCommentResponse>(
            requestCall: callRequest);
    return result;
  }
}
