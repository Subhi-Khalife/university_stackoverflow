import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';

abstract class CollageProfileRepository {
  Future<Either<Failure, CollageProfileModel>> getCollageProfile(
      int collageNum);
}
