import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/react/data/models/react_model.dart';

abstract class ReactRepository {
  Future<Either<Failure, ReactModel>> postReacts({Map<String, dynamic> items});
}
