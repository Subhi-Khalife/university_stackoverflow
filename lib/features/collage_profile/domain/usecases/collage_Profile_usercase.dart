import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';
import 'package:university/features/collage_profile/data/repository/collage_profile_repository_impl.dart';
import 'package:university/features/collage_profile/domain/repositories/collage_profile_repository.dart';

class CollageProfileUseCase extends UseCase<CollageProfileModel, int> {
  final CollageProfileRepository collageProfileRepository;

  CollageProfileUseCase({this.collageProfileRepository});

  @override
  Future<Either<Failure, CollageProfileModel>> call(int collageNum) async {
    final result = await collageProfileRepository.getCollageProfile(collageNum);
    return result;
  }
}
