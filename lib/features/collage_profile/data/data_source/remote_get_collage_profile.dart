import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/get_api.dart';
import '../../../../core/unified_api/handling_exception.dart';
import '../models/collage_profile.dart';

class RemoteGetCollageProfile with HandlingExceptionRequest {
  Future<Either<Failure, CollageProfileModel>> getCollageProfile(
      int collageNum) async {
    final getApi = GetApi<CollageProfileModel>(
      fromJson: collageProfileModelFromJson,
      url: "collegedetails/" + collageNum.toString(),
      requestName: "get collage profile",
    );
    final callRequest = getApi.callRequest;
    Either<Failure, CollageProfileModel> result =
        await getApi.handlingExceptionRequest(requestCall: callRequest);
    return result;
  }
}
