import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/collage_profile.dart';

abstract class CollageProfileRepository {
  Future<Either<Failure, CollageProfileModel>> getCollageProfile(
      int collageNum);
}
