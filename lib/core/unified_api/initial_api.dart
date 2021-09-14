import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/unified_api/constant_info.dart';

import 'handling_exception.dart';
import 'printing.dart';

abstract class InitialApi<T> extends Printing with HandlingExceptionRequest {
  String url;
  final String baseURL = ConstantApiInfo.baseUrl;
  String token;
  Map<String, String> header;

  InitialApi({this.token, @required this.url, String requestName})
      : super(requestName: requestName) {
    header = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json"
    };
  }

  Future<T> callRequest();
}
