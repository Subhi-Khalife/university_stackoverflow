import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/unified_api/get_api.dart';
import 'package:university/core/unified_api/handling_exception.dart';
import 'package:university/features/university_with_collage/data/models/universities_with_collages_model.dart';

class RemoteGetUniversityWithCollage with HandlingExceptionRequest {
  Future<Either<Failure, UniversitiesWithCollegesModel>>
      getUniversityWithCollage() async {
    final getApi = GetApi<UniversitiesWithCollegesModel>(
      url: 'universities',
      fromJson: universitiesWithCollegesFromJson,
      requestName: 'Get univesity with collage',
      token: null,
    );
    final getRequest = getApi.callRequest;
    final result =
        await getApi.handlingExceptionRequest(requestCall: getRequest);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
}
