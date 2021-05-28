import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/user_searches/search/data/models/add_search_model.dart';

abstract class AddSearchRepository {
  Future<Either<Failure, AddSearchModel>> postSearchs(
      {Map<String, dynamic> items});
}
