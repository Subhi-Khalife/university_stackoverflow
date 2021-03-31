import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/universities_with_collages_model.dart';

abstract class UniversityWithCollageRepositories {
  Future<Either<Failure, UniversitiesWithCollegesModel>>
      getAllUniversityWithCollage();
}
