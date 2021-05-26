import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/react/data/data_source/remote_post_react.dart';
import 'package:university/features/react/data/models/react_model.dart';
import 'package:university/features/react/domain/repositories/react_repository.dart';

class ReactRepositoryImpl implements ReactRepository {
  @override
  Future<Either<Failure, ReactModel>> postReacts(
      {Map<String, dynamic> items}) async {
    final postReacts = await RemotePostReact().postReacts();
    return postReacts;
  }
}
