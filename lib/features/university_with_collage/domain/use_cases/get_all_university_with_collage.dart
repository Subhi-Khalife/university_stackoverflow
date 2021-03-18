import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/universities_with_collages_model.dart';

class GetAllUniversityWithCollage
    extends UseCase<UniversitiesWithCollegesModel, dynamic> {
  @override
  Future<Either<Failure, UniversitiesWithCollegesModel>> call(params) {}
}
