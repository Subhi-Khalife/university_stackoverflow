import 'package:dartz/dartz.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/unified_api/delete_api.dart';
import 'package:university/features/comment/data/models/add_comment_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';

class DeleteComment with HandlingExceptionRequest {
  Future<Either<Failure, bool>> deleteComment(int commentId) async {
    ConstantInfo constantInfo = ConstantInfo.getInstance();
    final postApi = DeleteApi<bool>(
        fromJson: (String x) {
          return true;
        },
        token: constantInfo.userInfo.token,
        url: "comment/delete?comment_id=$commentId",
        requestName: " comment/updatdeletee --> delete  Comment ");
    final callRequest = postApi.callRequest;
    Either<Failure, bool> result =
        await handlingExceptionRequest<bool>(requestCall: callRequest);
    return result;
  }
}
