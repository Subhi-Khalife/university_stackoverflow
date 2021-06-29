import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/unified_api/get_api.dart';
import '../../../../../core/unified_api/handling_exception.dart';
import '../models/search_model.dart';

class RemoteGetSearchs with HandlingExceptionRequest {
  Future<Either<Failure, SearchModel>> getSearchs() async {
    final getApi = GetApi<SearchModel>(
      fromJson: searchModelFromJson,
      url: "searchs",
      requestName: "get search",
      token:
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI4IiwianRpIjoiZTQ1ZjY0OTU1Y2JlZjQ3NzQ3NzI1MzZhOWI0YzQ1YTA5ZDMwYjc2ZjA4MmJhNTY1NzU2ZmVhMmQ1NDg2YmJhMjM2ZTc4Mzc0ZGYxMTJiODUiLCJpYXQiOjE2MjIzNzcyNTUsIm5iZiI6MTYyMjM3NzI1NSwiZXhwIjoxNjUzOTEzMjU1LCJzdWIiOiIxMCIsInNjb3BlcyI6W119.O9yHu-YX3mgsmqFBzgo9jO9FnxUoGyO7L1vTqUHbOK_AyDSFR6juSIF_hYB1MNi-EbquVZSVwSBIs5CltRoUo7fY--ihGMtQoM2xjgHjVpzAhCKXlGkEmz5Zj4FDHpdL831W3CY-lRQhuwzffTxmkbjHuhlmXw4E-6FOXcgbK6hRzO2fUf8ry-4-JA2WruLEakz74J9rJBQQfEP3abzNXmHFAendwJfT1HaFPJ7hA221s691whjXHGBaVX5X6IdyW4ZinLDU51t64CFfRP_GmSfZl9KV328vdDa4nRLEAK2NBcRUcyxfSMt4fK1U0tXMmDc0Ai6KOL-0RKKVmOIYWzbIFQAt3smAPKjRdmZ5bsOT0MWTXzKQE-1PjVBE53IO5S6lYXbKMTJOS6xGDyDW9EihC4OjZQtO2Yh5VT3xGY3lSEDM1pBYkjIZyDAs-e6UfJSmvm3KlwTia1x_5K6E8lGX39Ju7YuEP1PqcgiNtUCY0ELOZZVS6nKHMGkf-cj9YiLYZE_rWDRvib0zwZNyR7DWQbphWpimrzRCvB0NIw1hytZ4atTW38pXXnfs7wKnR3HlrlNf9S2qFt2NijeZWc2x3I_AOOkja1BhiBuxisAuG62UFYXIF39kYdHw4DbCAEoAKsu2jJAqUkVO8k90O29CemuXTUne33bJAuoMy88",
    );
    final callRequest = getApi.callRequest;
    Either<Failure, SearchModel> result =
        await getApi.handlingExceptionRequest(requestCall: callRequest);
    return result;
  }
}
