import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'initial_api.dart';

typedef T _FromJson<T>(String body);

class DeleteApi<T> extends InitialApi<T> {
  _FromJson fromJson;
  DeleteApi(
      {@required String url,
      @required this.fromJson,
      String token,
      String requestName})
      : super(requestName: requestName, token: token, url: url);

  @override
  Future<T> callRequest() async {
    try {
      print("Deleting.......");

      final http.Response response = await http
          .delete(
            Uri.parse(baseURL + url),
            headers: header,
          )
          .timeout(Duration(seconds: 30));

      printResponse(response);

      if (response.statusCode == 250)
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
