import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/tabs/data/data_source/remote_get_tabs.dart';
import 'package:university/features/tabs/data/models/tab_model.dart';
import 'package:university/features/tabs/domain/repositories/tabs_repository.dart';

class TabsRepoImpl implements TabsRepository {
  @override
  Future<Either<Failure, TabModel>> getTabs() async {
    final callTabsRequest = await RemoteGetTabs().getTabs();
    return callTabsRequest;
  }
}
