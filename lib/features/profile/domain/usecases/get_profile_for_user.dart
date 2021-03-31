import 'package:university/core/entities/user.dart';
import 'package:university/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/profile/domain/repositories/profile_repositories.dart';

class GetProfileForUser extends UseCase<User, NoParams> {
  final ProfileRepository profileRepository;

  GetProfileForUser({this.profileRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    final result = await profileRepository.getUserProfile();
    return result;
  }
}
