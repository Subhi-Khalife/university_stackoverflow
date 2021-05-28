import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/search_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchModel>> getSearchs();
}
