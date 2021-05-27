import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/unified_api/get_api.dart';
import 'package:university/core/unified_api/handling_exception.dart';
import 'package:university/features/tabs/data/models/tab_model.dart';

class RemoteGetTabs with HandlingExceptionRequest {
  Future<Either<Failure, TabModel>> getTabs() async {
    final getApi = GetApi<TabModel>(
        fromJson: tabModelFromJson,
        url: "tab/get",
        requestName: "get tabs",
        token:
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI4IiwianRpIjoiNjdjMWY1OTFmOTM5YzlmNWUyNTgyYTM2N2ZiOGJkY2MzZWRhYTVmZDc0ZTg4MmJjZjFkZTQ2MGQ1OGRlZWJmYzQ0ZGEzOTQzMmE5YjE1YjciLCJpYXQiOjE2MjExMTY1ODksIm5iZiI6MTYyMTExNjU4OSwiZXhwIjoxNjUyNjUyNTg5LCJzdWIiOiIxMCIsInNjb3BlcyI6W119.1HgsjTrDOuXSBzfATtPiJ5Ru9n3QV6uE_hMyGJcvG9-STyJv4mdPLC-pMaUhOlnfwoTMHWb96-XJJJHbk46uLscxDILjuM9kU0oCTFi5JgXthm7-q71ixIA8wBayJfOez4BquIo2ElHjAMP1kzbOJouxikr35OgqQDWDGK2RxtjBcqr0_qFkSSodXowMlDJmsbTPSr69A_NUikPAvkuDBFAR_TKb7czWHuO3gq7H8S6-Ap_FVi43KKZXwffLOw2R0XZr41D3y1VS8PMzB-s5lQ34RSq0MtyDDusRpfhYsQ-ugqjMJOkoJ2owbfIPKFqZi_j9sNNC7KI69U-iDYFZTLCVmF0AT1MXJjHIWskhQaj9NDkh7GVbJD4MAAxKNGggX7cotbIT8Dlc_x-_IlTO1BTOnlzNc8Jb3ze57fGxOBzRHVc5aqT9Xu3MoXDeHWhe2MArrhVuFRGbWH1-wHEZiwPZD0v8e6N1JBVIqmp9MzW6pluJRC1zSkL0gFaOzLZ5nAiZpmN2mt1zmERLpkh-JXHBvtuhwKb6ILJHZLYKQisDrYLWQKgQu4Zr-AQZODGcYGAaTodDwVEntWPUFQTsXWVgJbupugsZMG4AIizltMgo5EOJig-n93n06hphnKnKPWNE6FAE45Wx0eoDz7ubKOvCxzvP1Ce309HhDP4NtWw");
    final callRequest = getApi.callRequest;
    Either<Failure, TabModel> result =
        await getApi.handlingExceptionRequest(requestCall: callRequest);
    return result;
  }
}
