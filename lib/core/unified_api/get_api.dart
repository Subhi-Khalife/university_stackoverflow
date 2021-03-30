import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'initial_api.dart';

typedef T _FromJson<T>(String body);

class GetApi<T> extends InitialApi<T> {
  _FromJson fromJson;
  GetApi(
      {@required String url,
      @required String token,
      @required this.fromJson,
      
      @required String requestName})
      : super(requestName: requestName, token: token, url: url);

  @override
  Future<T> callRequest() async {
    try {
      print("Getting.......");

      final http.Response response = await http
          .get(baseURL + url, headers: header)
          .timeout(Duration(seconds: 30));

      printResponse(response);

      if (response.statusCode == 200)
        return fromJson(response.body);
      else {
        Exception exception = getException(statusCode: response.statusCode);

        throw (exception);
      }
    } catch (exception) {
      print("the catch error  is : $exception");
      throw (exception);
    }
  }
}

//// <<<<--- Please don't clear this function --->>> !!!!!!!!!

// String passParam = getParam();

// String getParam() {
//   String requestParam = "?";
//   var keyList = param.keys.toList();
//   var valuesList = param.values.toList();
//
//   for (int i = 0; i < keyList.length; i++) {
//     requestParam = requestParam + keyList[i] + "=" + valuesList[i].toString + "&";
//   }
//   requestParam = requestParam.substring(0, requestParam.length - 1);
//   print("Param is : $requestParam");
//   return requestParam;
// }
