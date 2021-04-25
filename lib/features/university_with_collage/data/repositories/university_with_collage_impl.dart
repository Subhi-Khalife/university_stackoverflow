import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/university_with_collage_repositories.dart';
import '../data_sources/remote_get_university_with_collage.dart';
import '../models/universities_with_collages_model.dart';

class UniversityWithCollageImpl implements UniversityWithCollageRepositories {
  @override
  Future<Either<Failure, UniversitiesWithCollegesModel>>
      getAllUniversityWithCollage() async {
    final callGetRequest =
        await RemoteGetUniversityWithCollage().getUniversityWithCollage();
    return callGetRequest;
  }
}
