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
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI4IiwianRpIjoiNzgxZGM1NjI1YTU1Y2UzNTBhZjdmZjliYmY0NWJlNzVmYmU4ZmMzZTU0YWUyYmE5NDZmZDNjMjhmYTliZjZlYmM2YzM0NjBjYTM0OWRkNWYiLCJpYXQiOjE2MjEwMDE5NTgsIm5iZiI6MTYyMTAwMTk1OCwiZXhwIjoxNjUyNTM3OTU4LCJzdWIiOiIxMCIsInNjb3BlcyI6W119.qXBE72LPtDodg43ruMdQPDrY0t71sXqp3IduZJfEW7odOSrZsutPI7FBt7mRUt7tYrSgsUKXBInO8_c6mjoGBIPVdFkjGHwWZ19yecKmS7ZbHvwtwEj0oned8UcUXz0uK1RB93GgoFJ_t-AUQ8A0vFM0jG3y9xUX8nZeqlq5Va1HZgRNkpsm14vl6Iem6KrjtNF3VN6KEvk2-ZVXZUF31_kJumYn-ojPEfKkzi5tT2GNPbLUg8EkmI1jukVlHQpgweVq3oziHLKgiOu2W1gj3qSz_N0VATkC_q8qK9uMQA4nDVP6ITst78fSGA_eJQ6PKnql-pWh0wb3Z4o2zXjE1JYGFuYFroOGk4rZ1O-yhrvLZ0zmuMJANAQNbg1qPa-TXEOya2MGX0qlEGfaR76vdmrUVJ9qu4JNeFG-_6riLuqqVtM2qPVPnRfaz96RiB7cQLvyxRc5rCglveQat_ZnymRJYoj_XX_FcGLKOQ8iWF33GcIa-OD3EHouQlrpO5z7LJJ-0F4vqfRB8D8HSeSTKRK8h8mbe0QNqIcKCOTKuIZpJCa_cyyJ1EXxK-cQyeA6lfO8h8yzhQPME_qMMkvaxZv-w5zlw0edbTHmaxjuCUMXrHq2_Ua6KnJdSEi_5hQ7VBAwjb4nxtIHawPydVn3Q5BPz6M_oUw6mslxsHe1LCk",
    );
    final callRequest = getApi.callRequest;
    Either<Failure, SearchModel> result =
        await getApi.handlingExceptionRequest(requestCall: callRequest);
    return result;
  }
}
