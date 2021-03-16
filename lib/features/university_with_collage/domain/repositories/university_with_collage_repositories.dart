import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/university_with_collage/data/models/universities_with_collages_model.dart';

abstract class UniversityWithRepositories {
  Future<Either<Failure,UniversitiesWithCollegesModel>> getAllUniversityWithCollage();
}