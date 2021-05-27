import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../data_source/remote_get_searchs.dart';
import '../models/search_model.dart';
import '../../domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<Either<Failure, SearchModel>> getSearchs() async {
    final getAdvertisments = await RemoteGetSearchs().getSearchs();
    return getAdvertisments;
  }
}
