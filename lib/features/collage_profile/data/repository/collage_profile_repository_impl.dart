import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/collage_profile_repository.dart';
import '../data_source/remote_get_collage_profile.dart';
import '../models/collage_profile.dart';

class CollageProfileRepositoryImpl implements CollageProfileRepository {
  @override
  Future<Either<Failure, CollageProfileModel>> getCollageProfile(
      int collageNum) async {
    final callCollageProfileRequest =
        await RemoteGetCollageProfile().getCollageProfile(collageNum);
    return callCollageProfileRequest;
  }
}
