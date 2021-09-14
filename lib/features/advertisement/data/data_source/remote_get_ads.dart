import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/get_api.dart';
import '../../../../core/unified_api/handling_exception.dart';
import '../models/advertisment.dart';

class RemoteGetAdvertisment with HandlingExceptionRequest {
  Future<Either<Failure, AdvertisementModel>> getAds() async {
    final getApi = GetApi<AdvertisementModel>(
      fromJson: advertisementModelFromJson,
      url: "advertisings",
      requestName: "get advertisment",
    );
    final callRequest = getApi.callRequest;
    Either<Failure, AdvertisementModel> result =
        await getApi.handlingExceptionRequest(requestCall: callRequest);
    return result;
  }
}
