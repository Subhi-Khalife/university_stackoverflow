import 'package:dartz/dartz.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/unified_api/post_api.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';

class SetNewReact with HandlingExceptionRequest {
  Future<Either<Failure, bool>> setReact(Map<String, dynamic> param) async {
    ConstantInfo constantInfo = ConstantInfo.getInstance();
    final postApi = PostApi<NewPosts>(
        fromJson: (String x) {
          return true;
        },
        param: param,
        token: constantInfo.userInfo.token,
        url: "react",
        requestName: "React Post ");
    final callRequest = postApi.callRequest;
    Either<Failure, bool> result = await handlingExceptionRequest<bool>(requestCall: callRequest);
    return result;
  }
}
