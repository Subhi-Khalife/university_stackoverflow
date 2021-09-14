import 'package:dartz/dartz.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/unified_api/get_api.dart';
import 'package:university/core/unified_api/post_api.dart';
import 'package:university/features/post/data/models/get_all_replayes_model.dart';
import 'package:university/features/post/data/models/post_detail_model.dart';
import 'package:university/features/post/data/models/taps_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';

class GetAllPostReplayes with HandlingExceptionRequest {
  Future<Either<Failure, GetAllReplayesModel>> getAllPostReplayes(
      Map<String, dynamic> map) async {
    ConstantInfo constantInfo = ConstantInfo.getInstance();
    final getApi = GetApi<GetAllReplayesModel>(
        token: constantInfo.userInfo.token,
        fromJson: getAllReplayesModelFromJson,
        url: "comment/replies",
        requestName: "Get All Replayes --> comment/replies ",
        param: map);
    final callRequest = getApi.callRequest;
    Either<Failure, GetAllReplayesModel> result =
        await handlingExceptionRequest<GetAllReplayesModel>(
            requestCall: callRequest);
    return result;
  }
}
