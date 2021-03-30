import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/collage_profile/data/data_source/remote_get_collage_profile.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';
import 'package:university/features/collage_profile/domain/repositories/collage_profile_repository.dart';

class CollageProfileRepositoryImpl implements CollageProfileRepository {
  @override
  Future<Either<Failure, CollageProfileModel>> getCollageProfile(
      int collageNum) async {
    final callCollageProfileRequest =
        await RemoteGetCollageProfile().getCollageProfile(collageNum);
    return callCollageProfileRequest;
  }
}
