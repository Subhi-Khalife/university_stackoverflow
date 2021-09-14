import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/advertisment.dart';

abstract class AdvertismentRepository {
  Future<Either<Failure, AdvertisementModel>> getAds();
}
