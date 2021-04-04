import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/unified_api/get_api.dart';
import 'package:university/core/unified_api/handling_exception.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';

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
