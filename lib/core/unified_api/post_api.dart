import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:university/core/widget/show_message.dart';

import 'initial_api.dart';

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
          .post(Uri.parse(baseURL + url), headers: header, body: jsonEncode(param))
          .timeout(Duration(seconds: 30));

      printResponse(response);

      if (response.statusCode == 200 ||
          response.statusCode == 220 ||
          response.statusCode == 230 ||
          response.statusCode == 250)
        return fromJson(response.body);
      else {
        Map<String, dynamic> items = json.decode(response.body);
        String message = "";
        if (items["errors"] != null) {
          message = items["errors"][0] ?? "no internet connection";
        } else if (items["message"] != null) {
          message = items["message"] ?? "no internet connection";
        }
        showMessage(message);
        Exception exception = getException(statusCode: response.statusCode);

        throw (exception);
      }
    } catch (exception) {
      print("the catch error  is : $exception");
      throw (exception);
    }
  }
}
