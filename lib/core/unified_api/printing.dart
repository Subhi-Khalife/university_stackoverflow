import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Printing{

  String requestName;
  Printing({@required this.requestName});

  void printResponse (Response response) {
    print("The << status code >> into $requestName -> ${response.statusCode}");
    if (response.statusCode == 220) print("Success << GET >>    Request into -> $requestName");
    if (response.statusCode == 230) print("Success << POST >>   Request into -> $requestName");
    if (response.statusCode == 240) print("Success << PUT >>    Request into -> $requestName");
    if (response.statusCode == 250) print("Success << DELETE >> Request into -> $requestName");
    if (response.statusCode == 330)
      print("Data Duplicates Already Exists into $requestName");
    if (response.statusCode == 400) print("Missing Param into $requestName");
    if (response.statusCode == 460 || response.statusCode == 550)
      print("user not allowed to access this data into $requestName");
    if (response.statusCode == 560) print("operation failed into $requestName");
    if (response.statusCode == 499) print("token mismatch into $requestName");
    if (response.statusCode == 401) print("Data not Found into $requestName");
    if (response.statusCode == 522) print("Invalid Email Address into $requestName");
    if (response.statusCode == 477) print("Invalid Phone into $requestName");
    print("The << Body >> into $requestName -> ${response.body}");
  }
}