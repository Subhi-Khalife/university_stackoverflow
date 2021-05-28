import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/tabs/data/models/tab_model.dart';

abstract class TabsRepository {
  Future<Either<Failure, TabModel>> getTabs();
}
