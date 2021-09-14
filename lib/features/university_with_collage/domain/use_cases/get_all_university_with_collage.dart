import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/universities_with_collages_model.dart';
import '../repositories/university_with_collage_repositories.dart';

class GetAllUniversityWithCollage
    extends UseCase<UniversitiesWithCollegesModel, NoParams> {
  final UniversityWithCollageRepositories universityWithCollageRepositories;

  GetAllUniversityWithCollage({this.universityWithCollageRepositories});
  @override
  Future<Either<Failure, UniversitiesWithCollegesModel>> call(
      NoParams params) async {
    final result =
        await universityWithCollageRepositories.getAllUniversityWithCollage();
    return result;
  }
}
