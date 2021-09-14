import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/user_searches/search/data/models/del_search_model.dart';

abstract class DelSearchRepository {
  Future<Either<Failure, DelSearchModel>> delSearchs();
}
