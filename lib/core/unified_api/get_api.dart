import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:university/core/widget/show_message.dart';
import 'initial_api.dart';

typedef T _FromJson<T>(String body);

class GetApi<T> extends InitialApi<T> {
  _FromJson fromJson;
  Map<String, dynamic> param;
  String _passParam = "";
  GetApi(
      {@required String url,
      String token,
      @required this.fromJson,
      @required String requestName,
      this.param})
      : super(requestName: requestName, token: token, url: url) {
    _passParam = _getParam();
  }

  @override
  Future<T> callRequest() async {
    try {
      print("Getting.......${(baseURL + url + _passParam)}");
      final http.Response response = await http
          .get(Uri.parse(baseURL + url + _passParam), headers: header)
          .timeout(Duration(seconds: 30));
      printResponse(response);
      if (response.statusCode == 200 || response.statusCode == 220)
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

  String _getParam() {
    if (param == null) return "";
    String requestParam = "?";
    var keyList = param.keys.toList();
    var valuesList = param.values.toList();

    for (int i = 0; i < keyList.length; i++) {
      requestParam =
          requestParam + keyList[i] + "=" + valuesList[i].toString() + "&";
    }
    requestParam = requestParam.substring(0, requestParam.length - 1);
    print("Param is : $requestParam");
    return requestParam;
  }
}
