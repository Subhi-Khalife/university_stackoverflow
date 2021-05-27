import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/advertisment_repository.dart';
import '../data_source/remote_get_ads.dart';
import '../models/advertisment.dart';

class AdvertismentRepositoryImpl implements AdvertismentRepository {
  @override
  Future<Either<Failure, AdvertisementModel>> getAds() async {
    final getAdvertisments = await RemoteGetAdvertisment().getAds();
    return getAdvertisments;
  }
}
