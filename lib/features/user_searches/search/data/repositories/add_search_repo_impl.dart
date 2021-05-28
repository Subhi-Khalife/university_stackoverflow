import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/user_searches/search/data/data_source/remote_add_search.dart';
import 'package:university/features/user_searches/search/data/models/add_search_model.dart';
import 'package:university/features/user_searches/search/domain/repositories/add_search_repository.dart';

class AddSearchRepoImpl implements AddSearchRepository {
  @override
  Future<Either<Failure, AddSearchModel>> postSearchs(
      {Map<String, dynamic> items}) async {
    final addSearchs = await RemoteAddSearch().postSearchs(items);
    return addSearchs;
  }
}
