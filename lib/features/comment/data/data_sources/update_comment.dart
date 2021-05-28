import 'package:dartz/dartz.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/unified_api/post_api.dart';
import 'package:university/core/unified_api/put_api.dart';
import 'package:university/features/comment/data/models/add_comment_response.dart';
import 'package:university/features/comment/presentation/bloc/comment/comment_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';

class UpdateComment with HandlingExceptionRequest {
  Future<Either<Failure, AddCommentResponse>> updateComment(
      Map<String, dynamic> param) async {
    ConstantInfo constantInfo = ConstantInfo.getInstance();
    final postApi = PutApi<AddCommentResponse>(
        fromJson: addCommentResponseFromJson,
        param: param,
        token: constantInfo.userInfo.token,
        url: "comment/update",
        requestName: " comment/update --> update  Comment ");
    final callRequest = postApi.callRequest;
    Either<Failure, AddCommentResponse> result =
        await handlingExceptionRequest<AddCommentResponse>(
            requestCall: callRequest);
    return result;
  }
}
