import 'package:dartz/dartz.dart';
import 'package:university/core/entities/user.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/profile/data/data_source/local_profile_data_source.dart';
import 'package:university/features/profile/domain/repositories/profile_repositories.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Either<Failure, User>> getUserProfile() async {
    final callRequestResult = await LocalProfileDataSource().getUserProfile();
    return callRequestResult;
  }
}
