import 'package:university/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/university_with_collage/data/models/universities_with_collages_model.dart';

class GetAllUniversityWithCollage extends UseCase<UniversitiesWithCollegesModel,dynamic>{
  @override
  Future<Either<Failure, UniversitiesWithCollegesModel>> call(params) {
    
  }
  
}