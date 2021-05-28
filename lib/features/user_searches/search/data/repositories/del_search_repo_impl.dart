import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/user_searches/search/data/data_source/remote_del_search.dart';
import 'package:university/features/user_searches/search/data/models/del_search_model.dart';
import 'package:university/features/user_searches/search/domain/repositories/del_search_repository.dart';

class DelSearchRepoImpl implements DelSearchRepository {
  @override
  Future<Either<Failure, DelSearchModel>> delSearchs() async {
    final delSearchs = await RemoteDelSearch().delSearchs();
    return delSearchs;
  }
}
