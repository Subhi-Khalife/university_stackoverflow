import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/advertisment.dart';
import '../repositories/advertisment_repository.dart';

class AdvertismentUseCase extends UseCase<AdvertisementModel, GetAdsParam> {
  final AdvertismentRepository adsRepository;

  AdvertismentUseCase({this.adsRepository});

  @override
  Future<Either<Failure, AdvertisementModel>> call(
      GetAdsParam getAdsParam) async {
    final result = await adsRepository.getAds();
    return result;
  }
}

class GetAdsParam {}
