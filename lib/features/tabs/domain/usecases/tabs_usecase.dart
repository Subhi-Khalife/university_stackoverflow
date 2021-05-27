import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/tabs/data/models/tab_model.dart';
import 'package:university/features/tabs/domain/repositories/tabs_repository.dart';

class TabsUsecase extends UseCase<TabModel, GetTabsParam> {
  final TabsRepository tabsRepository;

  TabsUsecase({this.tabsRepository});

  @override
  Future<Either<Failure, TabModel>> call(GetTabsParam getTabsParam) async {
    final result = await tabsRepository.getTabs();
    return result;
  }
}

class GetTabsParam {}
