import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/university_with_collage/data/data_sources/remote_get_university_with_collage.dart';
import 'package:university/features/university_with_collage/data/models/universities_with_collages_model.dart';
import 'package:university/features/university_with_collage/domain/repositories/university_with_collage_repositories.dart';

class UniversityWithCollageImpl implements UniversityWithCollageRepositories {
  @override
  Future<Either<Failure, UniversitiesWithCollegesModel>>
      getAllUniversityWithCollage() async {
    final callGetRequest =
        await RemoteGetUniversityWithCollage().getUniversityWithCollage();
    return callGetRequest;
  }
}
