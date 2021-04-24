import 'package:dartz/dartz.dart';

import '../../../../core/entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/profile_repositories.dart';

class GetProfileForUser extends UseCase<User, NoParams> {
  final ProfileRepository profileRepository;

  GetProfileForUser({this.profileRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    final result = await profileRepository.getUserProfile();
    return result;
  }
}
