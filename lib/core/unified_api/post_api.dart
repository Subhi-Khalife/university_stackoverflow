import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:university/core/unified_api/initial_api.dart';

typedef T _FromJson<T>(String body);

class PostApi<T> extends InitialApi<T> {
  Map<String, dynamic> param;
  _FromJson fromJson;
  PostApi(
      {@required String url,
      @required this.param,
      @required this.fromJson,
      String token,
      String requestName})
      : super(requestName: requestName, token: token, url: url);

  @override
  Future<T> callRequest() async {
    try {
      print("The << param >> request $requestName -> $param");

      print("Posting.......");

      final http.Response response = await http
          .post(baseURL + url, headers: header, body: jsonEncode(param))
          .timeout(Duration(seconds: 30));

      printResponse(response);

      if (response.statusCode == 220)
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
