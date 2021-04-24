import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/collage_profile.dart';
import '../repositories/collage_profile_repository.dart';

class CollageProfileUseCase extends UseCase<CollageProfileModel, int> {
  final CollageProfileRepository collageProfileRepository;

  CollageProfileUseCase({this.collageProfileRepository});

  @override
  Future<Either<Failure, CollageProfileModel>> call(int collageNum) async {
    final result = await collageProfileRepository.getCollageProfile(collageNum);
    return result;
  }
}
