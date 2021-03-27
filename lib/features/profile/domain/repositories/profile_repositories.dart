import 'package:dartz/dartz.dart';
import 'package:university/core/entities/user.dart';
import 'package:university/core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getUserProfile();
}
