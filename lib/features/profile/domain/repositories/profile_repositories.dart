import 'package:dartz/dartz.dart';

import '../../../../core/entities/user.dart';
import '../../../../core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getUserProfile();
}
