import 'package:dartz/dartz.dart';

import 'package:university/core/constant_info.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/unified_api/get_api.dart';
import 'package:university/core/unified_api/post_api.dart';
import 'package:university/features/post/data/models/taps_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';

class GetAllTaps with HandlingExceptionRequest {
  Future<Either<Failure, TapsModel>> getAllTabs() async {
    ConstantInfo constantInfo = ConstantInfo.getInstance();
    final postApi = GetApi<TapsModel>(
        token: constantInfo.userInfo.token,
        fromJson: tapsModelFromJson,
        url: "tab/get",
        requestName: "Get All Taps");
    final callRequest = postApi.callRequest;
    Either<Failure, TapsModel> result =
        await handlingExceptionRequest<TapsModel>(requestCall: callRequest);
    return result;
  }
}
