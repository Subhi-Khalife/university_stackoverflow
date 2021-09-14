import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/rate/data/models/rate_model.dart';

abstract class RateRepository {
  Future<Either<Failure, RateModel>> postRate({Map<String, dynamic> items});
}
