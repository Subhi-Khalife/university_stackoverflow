import 'package:dartz/dartz.dart';

import '../../../../core/entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/profile_repositories.dart';
import '../data_source/local_profile_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Either<Failure, User>> getUserProfile() async {
    final callRequestResult = await LocalProfileDataSource().getUserProfile();
    return callRequestResult;
  }
}
